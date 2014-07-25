# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lita/ext/version'

Gem::Specification.new do |spec|
  spec.name          = "lita-ext"
  spec.version       = Lita::Ext::VERSION
  spec.authors       = ["Bryan Traywick"]
  spec.email         = ["bryan@railsmachine.com"]
  spec.description   = %q{A collection of extensions to the Lita chat bot.}
  spec.summary       = %q{A collection of extensions to the Lita chat bot.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", "~> 3.3.1"
  spec.add_runtime_dependency "dotenv"
  spec.add_runtime_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0.0.beta1"
  spec.add_development_dependency "rubocop"
end
