# frozen_string_literal: true

module ActionMosaico
  # The RichText record holds the content produced by the mosaico editor in a serialized +body+ attribute.
  # It also holds all the references to the embedded files, which are stored using Active Storage.
  # This record is then associated with the Active Record model the application desires to have
  # rich text content using the +has_rich_text+ class method.
  class RichText < Record
    self.table_name = 'action_mosaico_rich_texts'

    serialize :body, ActionMosaico::Content
    delegate :to_s, :nil?, to: :body

    belongs_to :record, polymorphic: true, touch: true
    has_many_attached :embeds

    before_save do
      self.embeds = body.attachables.grep(ActiveStorage::Blob).uniq if body.present?
    end

    def to_plain_text
      body&.to_plain_text.to_s
    end

    def to_mosaico_html
      body&.to_mosaico_html
    end

    delegate :blank?, :empty?, :present?, to: :to_plain_text
  end
end

ActiveSupport.run_load_hooks :action_mosaico_rich_text, ActionMosaico::RichText
