# frozen_string_literal: true
begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)

load "rails/tasks/engine.rake"

Bundler::GemHelper.install_tasks

Dir[File.join(File.dirname(__FILE__), "tasks/**/*.rake")].each { |f| load f }

require "rubocop/rake_task"

RuboCop::RakeTask.new

desc "Run Brakeman"
task :brakeman do
  dir = File.dirname(__FILE__)
  puts `#{ File.join(dir, "bin", "brakeman") } #{ File.join(dir, ".") }`
end

require "rspec/core"
require "rspec/core/rake_task"

desc "Run all specs in spec directory (excluding plugin specs)"
RSpec::Core::RakeTask.new(:spec)

task :default do
  Rake::Task["rubocop"].invoke
  Rake::Task["brakeman"].invoke
  Rake::Task["spec"].invoke
end
