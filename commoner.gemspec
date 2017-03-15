# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'commoner/version'

Gem::Specification.new do |spec|
  spec.name          = "commoner"
  spec.version       = Commoner::VERSION
  spec.authors       = ["Ross Cooperman"]
  spec.email         = ["cooperman@gmail.com"]
  spec.description   = %q{A simple interface to the Wikimedia Commons}
  spec.summary       = %q{Search Wikimedia Commons from Ruby? Don't mind if I do!}
  spec.homepage      = "http://github.com/thecoopermen/commoner"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency     "httparty", ">= 0.10"
  spec.add_runtime_dependency     "sanitize"

  spec.add_development_dependency "bundler",  "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
end
