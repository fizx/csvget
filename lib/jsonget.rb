require "rubygems"
require "rwget"
require "parsley"
require "activesupport"
require "fileutils"

class JSONStore
  def initialize(options = {})
    @output_folder = options[:prefix] || "."
    FileUtils.mkdir_p(@output_folder)
    @parselets = (options[:parselets] || []).map{|path| Parsley.new(File.read(path)) }
    @files     = (options[:parselets] || []).map{|path| File.open("#{File.basename(path)}.json", "a") }
  end

  def put(host, tmpfile)
    @parselets.zip(@files).each do |parselet, file|
      begin
        type = (`file "#{tmpfile.path}"` =~ /xml/i) ? :xml : :html
        output = parselet.parse(:file => tmpfile.path, :input => type, :output => :json) + ","
      rescue ParsleyError => e
        STDERR.puts "warning: #{e.message}"
      end
    end
  end

  def close
    @files.map(&:close)
  end
end