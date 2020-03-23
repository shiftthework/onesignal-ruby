# frozen_string_literal: true

module OneSignal
  module AutoMap
    def create_readers **attributes
      attributes.keys.each do |k|
        create_method k do
          attributes[k]
        end
      end
    end

    def create_method(name, &block)
      self.class.send(:define_method, name, &block)
    end
  end
end
