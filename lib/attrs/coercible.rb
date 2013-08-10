begin
  require 'coercible'
rescue LoadError => e
  puts "Coercion support requires coercible: gem install coercible"
  raise e
end

def Attrs(*attributes, &block)
  if attributes.size == 1 && attributes.first.is_a?(Hash)
    CoercibleAttrs.new(attributes.first, &block)
  else
    Attrs.new(*attributes, &block)
  end
end

module CoercibleAttrs
  def self.new(attributes, &block)
    Attrs.new(*attributes.keys) do
      const_set(:ATTRIBUTES, attributes)
      const_set(:COERCER, Coercible::Coercer.new)

      def self.attr(name, type)
        define_method :"#{name}=" do |val|
          coercion = "to_" + self.class::ATTRIBUTES[name].name.downcase
          val = self.class::COERCER[val.class].send(coercion, val)
          instance_variable_set(:"@#{name}", val)
        end

        private :"#{name}="
      end

      attributes.each { |name, type| attr(name, type) }

      class_eval(&block) if block_given?
    end
  end
end
