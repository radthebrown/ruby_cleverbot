# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_cleverbot/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby_cleverbot"
  spec.version       = RubyCleverbot::VERSION
  spec.authors       = ["Radagast"]
  spec.email         = ["radagast@openmailbox.org"]

  spec.summary       = %q{A simple gem to talk with CleverBot}
  spec.description   = %q{This gem is to send messages to cleverbot a get the responses.}
  spec.homepage      = "https://github.com/radthebrown/ruby_cleverbot"
  spec.license       = "MIT"

  spec.files         = %w(
    lib/ruby_cleverbot.rb
  )
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"

  spec.add_dependency "rest-client", "~> 1.6"
  spec.add_dependency "htmlentities", "~> 4.3"

  spec.required_ruby_version = '>= 1.9.3'
end
