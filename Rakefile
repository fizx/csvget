require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "csvget"
    gem.summary = %Q{Uses parselets and rwget to generate csv files from websites}
    gem.description = %Q{Super easy to use (but lots of dependencies :/) parser}
    gem.email = "kyle@kylemaxwell.com"
    gem.homepage = "http://github.com/fizx/csvget"
    gem.authors = ["Kyle Maxwell"]
    gem.add_dependency("fizx-rwget", ["> 0.2.3"])
    gem.add_dependency("fizx-parsley-ruby", ["> 0.0.0"])
    gem.add_dependency("activesupport", ["> 0.0.0"])
    gem.add_dependency("fastercsv", [">= 1.4.0"])
    
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "csvget #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
