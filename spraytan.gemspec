Gem::Specification.new do |s|
  s.name     = "spraytan"
  s.bindir   = "bin"
  s.executables = 'spraytan'
  s.version  = "0.2.3"
  s.date     = "2009-04-01"
  s.summary  = "rwget"
  s.email    = "kyle@kylemaxwell.com"
  s.homepage = "http://kylemaxwell.com"
  s.description = "Instant sunlight"
  s.has_rdoc = false
  s.files    = ["bin/rwget", "lib/rwget/controller.rb", "lib/rwget/dupes.rb", "lib/rwget/fetch.rb", "lib/rwget/links.rb", "lib/rwget/queue.rb", "lib/rwget/store.rb", "lib/rwget.rb", "README.markdown", "rwget-0.2.2.gem", "rwget.gemspec", "test/controller_test.rb", "test/dupes_test.rb", "test/fetch_test.rb", "test/links_test.rb", "test/queue_test.rb", "test/server.rb", "test/store_test.rb"]
  s.add_dependency("fizx-rwget", ["> 0.2.3"])
  s.add_dependency("fizx-parsley-ruby", ["> 0.0.0"])
  s.add_dependency("activesupport", ["> 0.0.0"])
  s.add_dependency("fastercsv", ["> 1.4.0"])
end