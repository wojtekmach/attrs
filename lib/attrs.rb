require 'attrs/version'

def Attrs(*args, &block)
  Attrs.new(*args, &block)
end

module Attrs
  def self.new(*attribute_names, &block)
    Class.new do
      const_set(:ATTRIBUTE_NAMES, attribute_names)

      def self.attribute_names
        self::ATTRIBUTE_NAMES
      end

      def self.attr(name)
        attr_accessor name
        private :"#{name}="
      end

      attribute_names.each { |name| attr name }

      def initialize(attributes)
        self.class.attribute_names.each do |name|
          self.send("#{name}=", attributes.fetch(name))
        end
      end

      def inspect
        "#<#{self.class.name} #{attributes.inspect}>"
      end

      def ==(other)
        to_hash == other.to_hash
      end

      def attributes
        self.class.attribute_names.each_with_object({}) do |name, hash|
          hash[name] = send(name)
        end
      end

      alias_method :to_hash, :attributes

      class_eval(&block) if block_given?
    end
  end
end
