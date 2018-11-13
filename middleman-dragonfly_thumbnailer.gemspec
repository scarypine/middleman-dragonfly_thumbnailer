# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'middleman/dragonfly_thumbnailer/version'

Gem::Specification.new do |spec|
  spec.name          = 'middleman-dragonfly_thumbnailer'
  spec.version       = Middleman::DragonflyThumbnailer::VERSION
  spec.authors       = ['Andrew White']
  spec.summary       = 'Thumbnail generation with Dragonfly'
  spec.description   = "Middleman Dragonfly Thumbnailer is a Middleman extension that lets you easily create thumbnails using Dragonfly's thumb processor."
  spec.homepage      = 'https://github.com/scarypine/middleman-dragonfly_thumbnailer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'

  spec.add_runtime_dependency('middleman-core', ['>= 3.2'])
  spec.add_runtime_dependency('dragonfly', ['>= 1.0.0'])
end
