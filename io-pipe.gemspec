# frozen_string_literal: true

require_relative "lib/io/pipe"

Gem::Specification.new do |spec|

  spec.name = "io-pipe"
  spec.version = IO::Pipe::VERSION
  spec.authors = ["Nobuyoshi Nakada"]
  spec.email = ["nobu@ruby-lang.org"]

  spec.summary = "Extended pipe command"
  spec.description =
    "An extension to the backtick method to allow additional options" \
    "to be passed to the command and IO#each method."
  spec.homepage = "https://github.com/nobu/io-pipe"
  spec.licenses = ["Ruby", "BSD-2-Clause"]
  spec.required_ruby_version = ">= 3.2.0" # new Data class

  # spec.metadata["allowed_push_host"] = ""

  # spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = ""

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  excludes = %w[test/ .git* Gemfile* [Rr]ake*] << File.basename(__FILE__)
  spec.files = *IO::Pipe::Command.new(%w[git ls-files -z] + excludes.map {":^:#{_1}"})
                  .each("\0", chomp: true, chdir: __dir__)

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
