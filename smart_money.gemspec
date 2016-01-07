# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smart_money/version'

Gem::Specification.new do |spec|
  spec.name          = "smart_money"
  spec.version       = SmartMoney::VERSION
  spec.authors       = ["khrystynaklochko"]
  spec.email         = ["khrystynaklochko@gmail.com"]

  spec.summary       = %q{Money smart converter and operations}
  spec.description   = %q{Simple gem to work with currency and money}
  spec.homepage      = "https://github.com/khrystynaklochko/smart_money"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "coveralls"
end
