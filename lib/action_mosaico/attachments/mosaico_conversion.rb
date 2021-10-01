# frozen_string_literal: true

require 'active_support/core_ext/object/try'

module ActionMosaico
  module Attachments
    module TrixConversion
      extend ActiveSupport::Concern

      class_methods do
        def fragment_by_converting_mosaico_attachments(content)
          Fragment.wrap(content).replace(TrixAttachment::SELECTOR) do |node|
            from_mosaico_attachment(TrixAttachment.new(node))
          end
        end

        def from_mosaico_attachment(mosaico_attachment)
          from_attributes(mosaico_attachment.attributes)
        end
      end

      def to_mosaico_attachment(content = mosaico_attachment_content)
        attributes = full_attributes.dup
        attributes['content'] = content if content
        TrixAttachment.from_attributes(attributes)
      end

      private

      def mosaico_attachment_content
        if partial_path = attachable.try(:to_mosaico_content_attachment_partial_path)
          ActionMosaico::Content.render(partial: partial_path, formats: :html, object: self, as: model_name.element)
        end
      end
    end
  end
end
