# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'async_job/version'

Gem::Specification.new do |spec|
  spec.name          = 'async_job'
  spec.version       = AsyncJob::VERSION
  spec.authors       = ['Marco Imperatore']
  spec.email         = ['mimperatore@gmail.com']

  spec.summary       = <<~ENDOFSTRING
    The best background job framework that's API-compatible with Sidekiq.
  ENDOFSTRING
  spec.description = <<~ENDOFSTRING
    The best background job framework that's API-compatible with Sidekiq.
  ENDOFSTRING
  spec.homepage      = 'https://mimperatore.github.io/async_job/'
  spec.license       = 'LGPL-3.0'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'byebug', '~> 11.0'
  spec.add_development_dependency 'codecov', '~> 0.1'
  spec.add_development_dependency 'guard', '~> 2.16'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 0.78'
  spec.add_development_dependency 'timecop', '~> 0.9'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_dependency 'fibonacci_heap'
end
