# frozen_string_literal: true

module ActionMosaico
  class Record < ActiveRecord::Base # :nodoc:
    self.abstract_class = true
  end
end

ActiveSupport.run_load_hooks :action_mosaico_record, ActionMosaico::Record
