Gem::Specification.new do |s|
  s.name     = "spraytan"
  s.bindir   = "bin"
  s.executables = 'spraytan'
  s.version  = "0.2.0"
  s.date     = "2009-04-01"
  s.summary  = "rwget"
  s.email    = "kyle@kylemaxwell.com"
  s.homepage = "http://kylemaxwell.com"
  s.description = "Instant sunlight"
  s.has_rdoc = false
  s.files    = %w[
    bin/spraytan
    lib/spraytan.rb
    Rakefile
    README
    README-SCHEMA
    spraytan.gemspec
    test/expected.csv
    test/foo.let
    test/spraytan_test.rb
  ]
  s.add_dependency("fizx-rwget", ["> 0.2.3"])
  s.add_dependency("fizx-parsley-ruby", ["> 0.0.0"])
  s.add_dependency("activesupport", ["> 0.0.0"])
  s.add_dependency("fastercsv", [">= 1.4.0"])
end