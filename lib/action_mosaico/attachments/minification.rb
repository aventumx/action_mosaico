# frozen_string_literal: true

module ActionMosaico
  module Attachments
    module Minification
      extend ActiveSupport::Concern

      class_methods do
        def fragment_by_minifying_attachments(content)
          Fragment.wrap(content).replace(ActionMosaico::Attachment.tag_name) do |node|
            node.tap { |n| n.inner_html = '' }
          end
        end
      end
    end
  end
end
