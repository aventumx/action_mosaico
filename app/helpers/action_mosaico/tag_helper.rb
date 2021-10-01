# frozen_string_literal: true

require 'active_support/core_ext/object/try'
require 'action_view/helpers/tags/placeholderable'

module ActionMosaico
  module TagHelper
    cattr_accessor(:id, instance_accessor: false) { 0 }

    # Returns a +mosaico-editor+ tag that instantiates the mosaico JavaScript editor as well as a hidden field
    # that mosaico will write to on changes, so the content will be sent on form submissions.
    #
    # ==== Options
    # * <tt>:class</tt> - Defaults to "mosaico-content" so that default styles will be applied.
    #   Setting this to a different value will prevent default styles from being applied.
    # * <tt>[:data][:direct_upload_url]</tt> - Defaults to +rails_direct_uploads_url+.
    # * <tt>[:data][:blob_url_template]</tt> - Defaults to <tt>rails_service_blob_url(":signed_id", ":filename")</tt>.
    #
    # ==== Example
    #
    #   rich_text_mosaico_tag "content", message.content
    #   # <input type="hidden" name="content" id="mosaico_input_post_1">
    #   # <mosaico-editor id="content" input="mosaico_input_post_1" class="mosaico-content" ...></mosaico-editor>
    def rich_text_mosaico_tag(name, value = nil, options = {})
      options = options.symbolize_keys
      form = options.delete(:form)

      options[:input] ||= "mosaico_input_#{ActionMosaico::TagHelper.id += 1}"
      options[:class] ||= 'mosaico-content'

      options[:data] ||= {}
      options[:data][:direct_upload_url] ||= main_app.rails_direct_uploads_url
      options[:data][:blob_url_template] ||= main_app.rails_service_blob_url(':signed_id', ':filename')

      editor_tag = content_tag('mosaico-editor', '', options)
      input_tag = hidden_field_tag(name, value.try(:to_mosaico_html) || value, id: options[:input], form: form)

      input_tag + editor_tag
    end
  end
end

module ActionView
  module Helpers
    module Tags
      class ActionMosaico < Tags::Base
        include Tags::Placeholderable

        delegate :dom_id, to: ActionView::RecordIdentifier

        def render
          options = @options.stringify_keys
          add_default_name_and_id(options)
          options['input'] ||= dom_id(object, [options['id'], :mosaico_input].compact.join('_')) if object
          @template_object.rich_text_mosaico_tag(options.delete('name'), options.fetch('value') do
                                                                           value
                                                                         end, options.except('value'))
        end
      end
    end

    module FormHelper
      # Returns a +mosaico-editor+ tag that instantiates the mosaico JavaScript editor as well as a hidden field
      # that mosaico will write to on changes, so the content will be sent on form submissions.
      #
      # ==== Options
      # * <tt>:class</tt> - Defaults to "mosaico-content" which ensures default styling is applied.
      # * <tt>:value</tt> - Adds a default value to the HTML input tag.
      # * <tt>[:data][:direct_upload_url]</tt> - Defaults to +rails_direct_uploads_url+.
      # * <tt>[:data][:blob_url_template]</tt> - Defaults to +rails_service_blob_url(":signed_id", ":filename")+.
      #
      # ==== Example
      #   form_with(model: @message) do |form|
      #     form.rich_text_mosaico :content
      #   end
      #   # <input type="hidden" name="message[content]" id="message_content_mosaico_input_message_1">
      #   # <mosaico-editor id="content" input="message_content_mosaico_input_message_1" class="mosaico-content" ...></mosaico-editor>
      #
      #   form_with(model: @message) do |form|
      #     form.rich_text_mosaico :content, value: "<h1>Default message</h1>"
      #   end
      #   # <input type="hidden" name="message[content]" id="message_content_mosaico_input_message_1" value="<h1>Default message</h1>">
      #   # <mosaico-editor id="content" input="message_content_mosaico_input_message_1" class="mosaico-content" ...></mosaico-editor>
      def rich_text_mosaico(object_name, method, options = {})
        Tags::ActionMosaico.new(object_name, method, self, options).render
      end
    end

    class FormBuilder
      def rich_text_mosaico(method, options = {})
        @template.rich_text_mosaico(@object_name, method, objectify_options(options))
      end
    end
  end
end
