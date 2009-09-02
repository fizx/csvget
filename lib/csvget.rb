require "rubygems"
require "rwget"
require "parsley"
require "fastercsv"
require "activesupport"
require "fileutils"

class CSVStore
  def initialize(options = {})
    @output_folder = options[:prefix] || "."
    @filters = options[:filter] || []
    FileUtils.mkdir_p(@output_folder)
    @parselets = (options[:parselets] || []).map{|path| Parsley.new(File.read(path)) }
    @files = {}
    @headers = {}
  end

  def put(host, tmpfile)
    @parselets.each do |parselet|
      begin
        output = parselet.parse(:file => tmpfile.path)
        walk(output)
      rescue ParsleyError => e
        STDERR.puts "warning: #{e.message}"
      end
    end
  end
  
  def walk(data, prefix = nil)
    data.each do |prefix, values|
      values = [values] unless values.is_a?(Array)
      file_name = File.join(@output_folder, "#{prefix}.csv")
      h = @headers[prefix] ||= values.first.keys
      f = @files[prefix] ||= FasterCSV.open(file_name, "a", :headers => h, :write_headers => true)
      
      values.each do |hash|
        arr = h.inject([]) do |memo, key|
          memo << hash[key]
        end
        @row = FasterCSV::Row.new(h, arr)
        @filters.each {|filter| eval(filter) }
        f << @row
      end
    end
  end

  def close
    @files.each do |k, v|
      v.close
    end
  end
end