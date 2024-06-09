# frozen_string_literal: true

require 'rubygems'
require 'rake'
require 'bundler'

Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task default: :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ''

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ruby-bugzilla #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Open an irb session preloaded with ruby-bugzilla'
task :console do
  sh 'irb -rubygems -I lib -r bugzilla.rb'
end
