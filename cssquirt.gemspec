# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cssquirt/version'

Gem::Specification.new do |spec|
  spec.name          = "cssquirt"
  spec.version       = CSSquirt::VERSION
  spec.authors       = ["Matthew Rothenberg"]
  spec.email         = ["mrothenberg@gmail.com"]
  spec.description   = %q{Embeds images (or directories of images) directly into CSS via the Data URI scheme.}
  spec.summary       = %q{Embeds images (or directories of images) directly into CSS via the Data URI scheme.}
  spec.homepage      = "http://github.com/mroth/cssquirt"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec",   "~> 3.4"
end
