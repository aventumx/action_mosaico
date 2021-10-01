# frozen_string_literal: true

desc 'Copy over the migration, stylesheet, and JavaScript files'
task 'action_mosaico:install' do
  Rails::Command.invoke :generate, ['action_mosaico:install']
end
