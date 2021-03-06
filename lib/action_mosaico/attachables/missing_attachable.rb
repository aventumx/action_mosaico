# frozen_string_literal: true

module ActionMosaico
  module Attachables
    module MissingAttachable
      extend ActiveModel::Naming

      def self.to_partial_path
        'action_mosaico/attachables/missing_attachable'
      end
    end
  end
end
