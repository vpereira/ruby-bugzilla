# frozen_string_literal: true

lib = File.expand_path('lib/', File.dirname(__FILE__))
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)
require 'bugzilla/version'

Gem::Specification.new do |s|
  s.name        = 'ruby-bugzilla'
  s.version     = Bugzilla::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Akira TAGOH']
  s.email       = ['akira@tagoh.org']
  s.homepage    = 'http://rubygems.org/gems/ruby-bugzilla'
  s.summary = %(Ruby binding for Bugzilla WebService APIs)
  s.description = %(This aims to provide similar features to access to Bugzilla through WebService APIs in Ruby.)
  s.license     = 'LGPL-3.0+'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'webmock'
  s.add_runtime_dependency 'gruff'
  s.add_runtime_dependency 'highline'
  s.add_runtime_dependency 'rake'
  s.add_runtime_dependency 'xmlrpc'

  # seems like gruff is missing this one
  # s.add_runtime_dependency "rmagick", "~> 0"
  s.executables = Dir.glob('bin/*').reject { |x| x =~ /~\Z/ }.map { |x| File.basename x }
  s.default_executable = 'bzconsole'

  s.files        = Dir.glob('lib/**/*[^~]') + %w[README.md COPYING]
  s.require_path = 'lib'
end
