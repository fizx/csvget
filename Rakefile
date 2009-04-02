task :default => :test

task :test => :build do
  Dir["test/*test*.rb"].each {|f| load f }
end

task :install do 
  system "gem uninstall -Ix fizx-spraytan"
  system "gem uninstall -Ix spraytan"
  system "gem build spraytan.gemspec"
  system "gem install spraytan"
end