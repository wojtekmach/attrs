require 'coercible'

def Attrs(*attributes)
  if attributes.size == 1 && attributes.first.is_a?(Hash)
    CoercibleAttrs.new(attributes.first)
  else
    Attrs.new(*attributes)
  end
end

module CoercibleAttrs
  def self.new(attributes)
    Class.new do
      const_set(:ATTRIBUTE_NAMES, attributes.keys)
      const_set(:ATTRIBUTES, attributes)
      const_set(:COERCER, Coercible::Coercer.new)

      extend ClassMethods
      include Attrs::InstanceMethods

      attributes.each { |name, type| attr(name, type) }
    end
  end

  module ClassMethods
    include Attrs::ClassMethods

    def attr(name, type)
      attr_reader name

      define_method :"#{name}=" do |val|
        coercion = "to_" + self.class::ATTRIBUTES[name].name.downcase
        val = self.class::COERCER[val.class].send(coercion, val)
        instance_variable_set(:"@#{name}", val)
      end

      private :"#{name}="
    end
  end
end
