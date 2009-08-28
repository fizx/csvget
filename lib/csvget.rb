require "rubygems"
require "rwget"
require "parsley"
require "fastercsv"
require "activesupport"
require "fileutils"

class CSVStore
  def initialize(options = {})
    @output_folder = options[:prefix] || "."
    FileUtils.mkdir_p(@output_folder)
    @parselets = (options[:parselets] || []).map{|path| Parsley.new(File.read(path)) }
    @files = {}
    @headers = {}
  end

  def put(host, tmpfile)
    @parselets.each do |parselet|
      begin
        output = parselet.parse(:file => temp_file.path)
        walk(output)
      rescue ParsleyError => e
        STDERR.puts "warning: #{e.message}"
      end
    end
  end
  
  def walk(data, prefix = nil)
    data.each do |prefix, values|
      file_name = File.join(@output_folder, "#{prefix}s.csv")
      first_row = values.is_a?(Array) ? values.first : values
      @files[prefix] ||= FasterCSV.open(file_name, "a", :headers => h, :write_headers => true)
      @headers[prefix] ||= first_row.keys
      
      @files[prefix] << @headers[prefix].inject([]) do |memo, key|
        memo << values[key]
      end
    end
  end

  def close
    @files.each do |k, v|
      v.close
    end
  end
end