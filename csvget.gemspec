# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{csvget}
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kyle Maxwell"]
  s.date = %q{2009-09-10}
  s.description = %q{Super easy to use (but lots of dependencies :/) parser}
  s.email = %q{kyle@kylemaxwell.com}
  s.executables = ["csvget", "jsonget"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "CHANGELOG",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/csvget",
     "bin/jsonget",
     "csvget.gemspec",
     "hn.let",
     "lib/csvget.rb",
     "lib/jsonget.rb",
     "test/csvget_test.rb"
  ]
  s.homepage = %q{http://github.com/fizx/csvget}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Uses parselets and rwget to generate csv files from websites}
  s.test_files = [
    "test/csvget_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fizx-rwget>, ["> 0.2.3"])
      s.add_runtime_dependency(%q<fizx-parsley-ruby>, ["> 0.0.0"])
      s.add_runtime_dependency(%q<activesupport>, ["> 0.0.0"])
      s.add_runtime_dependency(%q<fastercsv>, [">= 1.4.0"])
    else
      s.add_dependency(%q<fizx-rwget>, ["> 0.2.3"])
      s.add_dependency(%q<fizx-parsley-ruby>, ["> 0.0.0"])
      s.add_dependency(%q<activesupport>, ["> 0.0.0"])
      s.add_dependency(%q<fastercsv>, [">= 1.4.0"])
    end
  else
    s.add_dependency(%q<fizx-rwget>, ["> 0.2.3"])
    s.add_dependency(%q<fizx-parsley-ruby>, ["> 0.0.0"])
    s.add_dependency(%q<activesupport>, ["> 0.0.0"])
    s.add_dependency(%q<fastercsv>, [">= 1.4.0"])
  end
end
