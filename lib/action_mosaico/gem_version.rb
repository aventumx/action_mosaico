# frozen_string_literal: true

module ActionMosaico
  # Returns the currently-loaded version of Action Mosaico as a <tt>Gem::Version</tt>.
  def self.gem_version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 0
    MINOR = 1
    TINY  = 0
    PRE   = ''

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end
end
