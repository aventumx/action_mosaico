# frozen_string_literal: true

require 'pathname'
require 'json'

module ActionMosaico
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path('templates', __dir__)

      def install_javascript_dependencies
        if Pathname(destination_root).join('package.json').exist?
          say 'Installing JavaScript dependencies', :green
          run 'yarn add action_mosaico mosaico'
        end
      end

      def append_javascript_dependencies
        destination = Pathname(destination_root)

        if (application_javascript_path = destination.join('app/javascript/application.js')).exist?
          insert_into_file application_javascript_path.to_s, %(import "mosaico"\nimport actionmosaico"\n)
        else
          say <<~INSTRUCTIONS, :green
            You must import the actionmosaico and mosaico JavaScript modules in your application entrypoint.
          INSTRUCTIONS
        end

        if (importmap_path = destination.join('config/importmap.rb')).exist?
          append_to_file importmap_path.to_s, %(pin "mosaico"\npin "actionmosaico", to: "actionmosaico.js"\n)
        end
      end

      def create_actionmosaico_files
      end

      def enable_image_processing_gem
        if (gemfile_path = Pathname(destination_root).join('Gemfile')).exist?
          say 'Ensure image_processing gem has been enabled so image uploads will work (remember to bundle!)'
          uncomment_lines gemfile_path, /gem "image_processing"/
        end
      end

      def create_migrations
        rails_command 'railties:install:migrations FROM=active_storage,action_mosaico', inline: true
      end

      hook_for :test_framework
    end
  end
end
