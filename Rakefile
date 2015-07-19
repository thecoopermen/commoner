require 'rspec/core/rake_task'
require 'bundler/gem_tasks'

# Default directory to look in is '\specs'
# Run with 'rake spec'
RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['--color', '--format', 'nested']
end

desc "Open an irb session preloaded with this library. 'Rake console'"
task :console do
  sh "irb -rubygems -I lib -r commoner.rb"
end

task :default => :spec
