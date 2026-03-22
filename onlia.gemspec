require_relative "lib/onlia/version"

Gem::Specification.new do |spec|
  spec.name = "onlia"
  spec.version = Onlia::VERSION
  spec.authors = ["Manpreet"]
  spec.email = ["manpreet@metawarelabs.com"]

  spec.summary = %q{Onlia is a Ruby gem that provides a simple interface to the Onlia API.}
  spec.description = %q{Onlia is a Ruby gem that provides a simple interface to the Onlia API. It allows you to request quote from Onlia API.}
  spec.homepage = "https://roam.auto"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.2.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/metaware/onlia"
  spec.metadata["changelog_uri"] = "https://github.com/metaware/onlia/Readme.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency("pry")

  spec.add_dependency("rest-client", ">= 2.1.0")
  spec.add_dependency("jwt", "~> 2.2")
end
