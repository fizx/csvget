require "rubygems"
require "rwget"
require "parsley"
require "fastercsv"
require "activesupport"
require "fileutils"

class DontStore
  def initialize(*args); end
  def put(*args); end
end

class ParseletLinks
  attr_accessor :output_folder
  
  SCHEMA = %w[
    
      bill-state
      bill-chamber
      bill-session
      bill-bill_id
      bill-name
      bill-guid

      bill_version-bill
      bill_version-name
      bill_version-url

      sponsorship-bill_state
      sponsorship-bill_id
      sponsorship-bill_chamber
      sponsorship-bill_session
      sponsorship-sponsor_type
      sponsorship-sponsor_name

      action-bill
      action-chamber
      action-text
      action-date
      
  ]
  
  PREFIXES = %w[bill bill_version sponsorship action]
  INDIVIDUAL = PREFIXES.map{|p| "#{p}-"}
  PLURAL = PREFIXES.map{|p| "#{p}s"}
  
  def initialize(options = {})
    @output_folder = options[:prefix] || "."
    FileUtils.mkdir_p(@output_folder)
    @parselets = (options[:parselets] || []).map{|path| Parsley.new(File.read(path)) }
    @files = {}
  end
  
  def headers
    @rubified_schema ||= SCHEMA.inject({}) do |memo, key|
      prefix, field = key.split("-")
      memo[prefix] ||= []
      memo[prefix] << field
      memo
    end
  end
  
  def add_parselet(path)
    @parselets << Parsley.new(File.read(path))
  end
  
  def walk(data, prefix = nil)
    output = {}
    
    data.each do |k, v|
      if pre = prefix || INDIVIDUAL.find{|pre| k.starts_with?(pre) }
        pre.gsub!("-", "")
        output[pre] ||= {}
        output[pre][k.split("-").last] = v
      elsif key = PLURAL.find{|pre| k == pre } && v.is_a?(Array)
        key.gsub!(/s$/, "")  # singular
        v.each{|entry| walk(entry, key)}
      end
    end
    
    output.each do |prefix, values|
      file_name = File.join(@output_folder, "#{prefix}s.csv")
      h = headers[prefix]
      @files[prefix] ||= FasterCSV.open(file_name, "a", :headers => h, :write_headers => true)
      @files[prefix] << h.inject([]) do |memo, key|
        memo << values[key]
      end
    end
  end
  
  def close
    @files.each do |k, v|
      v.close
    end
  end
  
  def urls(base_uri, temp_file)
    # STDE
    urls = []
    @parselets.each do |parselet|
      begin
        output = parselet.parse(:file => temp_file.path)
        urls += [output["links"]].compact.flatten.map{|u| URI.join(base_uri, u) rescue nil }.compact
        STDERR.puts "walking... #{output.inspect}"
        walk(output)
      rescue ParsleyError => e
        STDERR.puts "warning: #{e.message}"
      end
    end
    return urls
  end
end