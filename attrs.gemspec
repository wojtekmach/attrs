# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'attrs/version'

Gem::Specification.new do |spec|
  spec.name          = "attrs"
  spec.version       = Attrs::VERSION
  spec.authors       = ["Wojciech Mach"]
  spec.email         = ["wojtek@wojtekmach.pl"]
  spec.description   = "Yet another attributes on steroids gem"
  spec.summary       = gem.description
  spec.homepage      = "https://github.com/wojtekmach/attrs"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
