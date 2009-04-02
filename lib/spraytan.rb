require "rubygems"
require "rwget"

module Spraytan
  class ParseletLinks
    attr_accessor :output_folder
    
    SCHEMA = %w[
      
        bill-state
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
    
    PREFIXES = %[bill bill_version sponsorship action]
    INDIVIDUAL = PREFIXES.map{|p| "#{p}-"}
    PLURAL = PREFIXES.map{|p| "#{p}s"}
    
    def initialize
      @output_folder = "."
      @parselets = []
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
        file[prefix] ||= FasterCSV.open(file_name, "a", :headers => headers["#{prefix}s"], :write_headers => true)
        end
      end
    end
    
    def urls(base_uri, temp_file)
      urls = []
      @parselets.each do |parselet|
        begin
          output = parselet.parse(:file => temp_file.path)
          urls += [output["links"]].compact.flatten
          walk(output)
        rescue ParsleyError => e
          STDERR.puts "warning: #{e.message}"
        end
      end
      return urls
    end
  end
end