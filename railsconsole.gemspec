# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_console/version'

Gem::Specification.new do |spec|
  spec.name          = 'railsconsole'
  spec.version       = RailsConsole::VERSION
  spec.date          = '2019-01-29'
  spec.summary       = "Rails production console!"
  spec.description   = "Access of production rails console from deploy file."
  spec.authors       = ["Hugo Demiglio"]
  spec.email         = 'hugodemiglio@gmail.com'
  spec.files         = ["lib/rails_console.rb"]
  spec.require_paths = ['lib']
  spec.executables   = ['railsconsole']
  spec.homepage      = 'http://rubygems.org/gems/rails_console'
  spec.license       = 'MIT'
end
