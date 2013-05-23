#############################################################################
#
# Helper functions
#
#############################################################################

def name
    @name ||= Dir['*.gemspec'].first.split('.').first
end

def version
    line = File.read("lib/#{name}.rb")[/^\s*VERSION\s*=\s*.*/]
      line.match(/.*VERSION\s*=\s*['"](.*)['"]/)[1]
end

def date
    Date.today.to_s
end

def gemspec_file
    "#{name}.gemspec"
end

def gem_file
    "#{name}-#{version}.gem"
end

def replace_header(head, header_name)
    head.sub!(/(\.#{header_name}\s*= ').*'/) { "#{$1}#{send(header_name)}'"}
end

#############################################################################
#
# Standard tasks
#
#############################################################################

require 'rspec'
require 'rspec/core/rake_task'

desc "Run all specs"
task RSpec::Core::RakeTask.new('spec')

task :default => "spec"

#TODO (jchristie+nilmethod) add custom ripl console and pry tasks
desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -r ./lib/#{name}.rb"
end
