source ENV['GEM_SOURCE'] || "https://rubygems.org"

def location_for(place, fake_version = nil)
  if place =~ /^(git[:@][^#]*)#(.*)/
    [fake_version, { :git => $1, :branch => $2, :require => false }].compact
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { :path => File.expand_path($1), :require => false }]
  else
    [place, { :require => false }]
  end
end

if ENV.key?('PUPPET_VERSION')
  puppetversion = "~> #{ENV['PUPPET_VERSION']}"
else
  puppetversion = ['>= 3.3.1', '< 4']
end

group :build do
  gem 'librarian-repo', :git => 'https://github.com/msutter/librarian-repo.git'
  gem 'cim'
  gem 'mof', :git => 'https://github.com/puppetlabs/mof.git'
  gem 'charlock_holmes'
end

group :development do
  gem 'rake', '>=0.9.2.2'
  gem 'puppet-blacksmith'
  gem 'pry'
  gem 'librarian-puppet', '>=1.0.2'
end

group :test do
  gem 'puppet', *location_for(ENV['PUPPET_LOCATION'] || puppetversion)
  gem 'puppet-lint', '>=0.3.2'
  gem 'puppetlabs_spec_helper', '>=0.2.0'
  gem 'iconv', '~> 1.0.4' if RUBY_VERSION >= '2.0'
end

beaker_version = ENV['BEAKER_VERSION']
unless ENV['GEM_SOURCE'].nil?
  group :system_tests do
    if beaker_version
      gem 'beaker', *location_for(beaker_version)
    else
      gem 'beaker', '~> 2.16'
    end
    gem 'master_manipulator', '~> 1.1'
  end
end

if File.exists? "#{__FILE__}.local"
  eval(File.read("#{__FILE__}.local"), binding)
end
