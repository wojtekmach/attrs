require 'attrs/version'

def Attrs(*args)
  Attrs.new(*args)
end

module Attrs
  def self.new(*attribute_names)
    Class.new do
      const_set(:ATTRIBUTE_NAMES, attribute_names)
      extend Attrs::ClassMethods
      include Attrs::InstanceMethods
    end
  end

  module ClassMethods
    def attribute_names
      self::ATTRIBUTE_NAMES
    end

    def attr(name)
      attr_accessor name
      private :"#{name}="
    end
  end

  module InstanceMethods
    def self.included(base)
      base.attribute_names.each { |name| base.attr name }
    end

    def initialize(attributes)
      self.class.attribute_names.each do |name|
        self.send("#{name}=", attributes.fetch(name))
      end
    end

    def attributes
      self.class.attribute_names.each_with_object({}) do |name, hash|
        hash[name] = send(name)
      end
    end

    def ==(other)
      to_hash == other.to_hash
    end

    alias_method :to_hash, :attributes
  end
end
