# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zcloudjp/version'

Gem::Specification.new do |spec|
  spec.name          = "zcloudjp"
  spec.version       = Zcloudjp::VERSION
  spec.authors       = ["azukiwasher"]
  spec.email         = ["azukiwasher@higanworks.com"]
  spec.description   = %q{A Ruby interface to the Z Cloud API.}
  spec.summary       = %q{A Ruby interface to the Z Cloud API.}
  spec.homepage      = "https://github.com/giraffi/zcloudjp"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activesupport', "~> 4.0"
  spec.add_runtime_dependency 'httparty', "~> 0.11"
  spec.add_runtime_dependency 'multi_json', "~> 1.7"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'
end
