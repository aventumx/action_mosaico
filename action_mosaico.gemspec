# frozen_string_literal: true

require_relative 'lib/action_mosaico/version'

Gem::Specification.new do |spec|
  spec.name          = 'action_mosaico'
  spec.version       = ActionMosaico::VERSION
  spec.authors       = ['Recker Swartz']
  spec.email         = ['reckerswartz@hotmail.com']

  spec.summary       = 'The Mosaico email editor on Rails.'
  spec.description   = 'The Mosaico email editor on Rails.'
  spec.homepage      = 'https://github.com/aventumx/action_mosaico'
  spec.license       = 'MIT'
  spec.required_ruby_version     = '>= 2.7.0'
  spec.required_rubygems_version = '>= 1.8.11'

  spec.metadata['allowed_push_host'] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/aventumx/action_mosaico'
  spec.metadata['changelog_uri'] = 'https://github.com/aventumx/action_mosaico'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  spec.add_dependency 'activesupport', '~> 6.1'
  spec.add_dependency 'activerecord',  '~> 6.1'
  spec.add_dependency 'activestorage', '~> 6.1'
  spec.add_dependency 'actionpack',    '~> 6.1'

  spec.add_dependency 'nokogiri', '>= 1.8.5'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
