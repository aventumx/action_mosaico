# frozen_string_literal: true

require 'active_support'
require 'active_support/rails'

require 'nokogiri'

module ActionMosaico
  extend ActiveSupport::Autoload

  autoload :Attachable
  autoload :AttachmentGallery
  autoload :Attachment
  autoload :Attribute
  autoload :Content
  autoload :Encryption
  autoload :Fragment
  autoload :FixtureSet
  autoload :HtmlConversion
  autoload :PlainTextConversion
  autoload :Rendering
  autoload :Serialization
  autoload :MosaicoAttachment

  module Attachables
    extend ActiveSupport::Autoload

    autoload :ContentAttachment
    autoload :MissingAttachable
    autoload :RemoteImage
  end

  module Attachments
    extend ActiveSupport::Autoload

    autoload :Caching
    autoload :Minification
    autoload :MosaicoConversion
  end
end
