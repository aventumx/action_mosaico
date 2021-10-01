# frozen_string_literal: true

module ActionMosaico
  class EncryptedRichText < RichText
    self.table_name = 'action_mosaico_rich_texts'

    encrypts :body
  end
end
