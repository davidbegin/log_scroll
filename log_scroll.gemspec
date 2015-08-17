# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'log_scroll/version'

Gem::Specification.new do |spec|
  spec.name          = "log_scroll"
  spec.version       = LogScroll::VERSION
  spec.authors       = ["David Begin"]
  spec.email         = ["davidmichaelbe@gmail.com"]

  spec.summary       = %q{A simple gem for managing rolling Logs}
  spec.description   = %q{Rolling Logs in Ruby}
  spec.homepage      = "https://github.com/presidentJFK/log-scroll"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
