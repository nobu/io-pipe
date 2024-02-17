# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

task default: %i[test]

Rake::TestTask.new(:test) do |t|
  t.libs << "test/lib"
  t.ruby_opts << "-rhelper"
  t.test_files = FileList["test/**/test_*.rb"]
end
