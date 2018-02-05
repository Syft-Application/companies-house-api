# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'companies_house/version'

Gem::Specification.new do |spec|
  spec.name          = 'companies-house-api'
  spec.version       = CompaniesHouse::VERSION
  spec.authors       = ['SyftApp Engineering']
  spec.email         = ['developers@syftapp.com']
  spec.license       = 'MIT'

  spec.summary       = 'Look up UK Limited companies'
  spec.description   = 'Client for the Companies House search companies REST API.'
  spec.homepage      = 'https://github.com/Syft-Application/companies-house-api'

  spec.files         = `git ls-files -z lib/ *.gemspec README.md`.split("\x0")
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.3'
  spec.add_runtime_dependency 'virtus', '~> 1.0', '>= 1.0.5'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rubocop', '~> 0.52'
  spec.add_development_dependency 'webmock', '~> 3.0'
end
