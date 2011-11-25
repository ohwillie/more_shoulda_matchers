# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'more-shoulda-matchers/version'

Gem::Specification.new do |s|
  s.name        = 'more-shoulda-matchers'
  s.version     = MoreShouldaMatchers::VERSION
  s.authors     = ['Rob Hanlon']
  s.email       = ['rob@mediapiston.com']
  s.homepage    = 'http://github.com/ohwillie'
  s.summary     = %q{An extended set of shoulda matchers.}
  s.description = %q{An extended set of shoulda matchers.}

  s.rubyforge_project = 'more-shoulda-matchers'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_development_dependency('rspec', '~> 2.7.0')
  s.add_development_dependency('activerecord', '~> 3.1.3')
end
