# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + "/lib/csstree.rb"

Gem::Specification.new do |gem|
  gem.authors       = ["Matte Noble"]
  gem.email         = ["me@mattenoble.com"]
  gem.description   = %q{Ultra-simple CSS parser.}
  gem.summary       = %q{Ultra-simple CSS parser.}

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "csstree"
  gem.require_paths = ["lib"]
  gem.version       = CSSTree::VERSION

  gem.add_development_dependency "rspec", "~> 2.6.0"
end
