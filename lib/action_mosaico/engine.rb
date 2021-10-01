# frozen_string_literal: true

require 'rails'
require 'action_controller/railtie'
require 'active_record/railtie'
require 'active_storage/engine'

require 'action_mosaico'

module ActionMosaico
  class Engine < Rails::Engine
    isolate_namespace ActionMosaico
    config.eager_load_namespaces << ActionMosaico

    config.action_mosaico = ActiveSupport::OrderedOptions.new
    config.action_mosaico.attachment_tag_name = 'action-text-attachment'
    config.autoload_once_paths = %W[
      #{root}/app/helpers
      #{root}/app/models
    ]

    initializer 'action_mosaico.attribute' do
      ActiveSupport.on_load(:active_record) do
        include ActionMosaico::Attribute
        prepend ActionMosaico::Encryption
      end
    end

    initializer 'action_mosaico.asset' do
      if Rails.application.config.respond_to?(:assets)
        Rails.application.config.assets.precompile += %w[action_mosaico.js mosaico.js mosaico.css]
      end
    end

    initializer 'action_mosaico.attachable' do
      ActiveSupport.on_load(:active_storage_blob) do
        include ActionMosaico::Attachable

        def previewable_attachable?
          representable?
        end

        def attachable_plain_text_representation(caption = nil)
          "[#{caption || filename}]"
        end

        def to_mosaico_content_attachment_partial_path
          nil
        end
      end
    end

    initializer 'action_mosaico.helper' do
      %i[action_controller_base action_mailer].each do |abstract_controller|
        ActiveSupport.on_load(abstract_controller) do
          helper ActionMosaico::Engine.helpers
        end
      end
    end

    initializer 'action_mosaico.renderer' do
      ActiveSupport.on_load(:action_mosaico_content) do
        self.default_renderer = Class.new(ActionController::Base).renderer
      end

      %i[action_controller_base action_mailer].each do |abstract_controller|
        ActiveSupport.on_load(abstract_controller) do
          around_action do |controller, action|
            ActionMosaico::Content.with_renderer(controller, &action)
          end
        end
      end
    end

    initializer 'action_mosaico.system_test_helper' do
      ActiveSupport.on_load(:action_dispatch_system_test_case) do
        require 'action_mosaico/system_test_helper'
        include ActionMosaico::SystemTestHelper
      end
    end

    initializer 'action_mosaico.configure' do |app|
      ActionMosaico::Attachment.tag_name = app.config.action_mosaico.attachment_tag_name
    end
  end
end
