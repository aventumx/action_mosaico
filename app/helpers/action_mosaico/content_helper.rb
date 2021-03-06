# frozen_string_literal: true

require 'rails-html-sanitizer'

module ActionMosaico
  module ContentHelper
    mattr_accessor(:sanitizer) { Rails::Html::Sanitizer.safe_list_sanitizer.new }
    mattr_accessor(:allowed_tags) do
      sanitizer.class.allowed_tags + [ActionMosaico::Attachment.tag_name, 'figure', 'figcaption']
    end
    mattr_accessor(:allowed_attributes) { sanitizer.class.allowed_attributes + ActionMosaico::Attachment::ATTRIBUTES }
    mattr_accessor(:scrubber)

    def render_action_mosaico_content(content)
      self.prefix_partial_path_with_controller_namespace = false
      sanitize_action_mosaico_content(render_action_mosaico_attachments(content))
    end

    def sanitize_action_mosaico_content(content)
      sanitizer.sanitize(content.to_html, tags: allowed_tags, attributes: allowed_attributes,
                                          scrubber: scrubber).html_safe
    end

    def render_action_mosaico_attachments(content)
      content.render_attachments do |attachment|
        unless attachment.in?(content.gallery_attachments)
          attachment.node.tap do |node|
            node.inner_html = render_action_mosaico_attachment attachment, locals: { in_gallery: false }
          end
        end
      end.render_attachment_galleries do |attachment_gallery|
        render(layout: attachment_gallery, object: attachment_gallery) do
          attachment_gallery.attachments.map do |attachment|
            attachment.node.inner_html = render_action_mosaico_attachment attachment, locals: { in_gallery: true }
            attachment.to_html
          end.join.html_safe
        end.chomp
      end
    end

    def render_action_mosaico_attachment(attachment, locals: {}) # :nodoc:
      options = { locals: locals, object: attachment, partial: attachment }

      options[:partial] = attachment.to_attachable_partial_path if attachment.respond_to?(:to_attachable_partial_path)

      options[:as] = attachment.model_name.element if attachment.respond_to?(:model_name)

      render(**options).chomp
    end
  end
end
