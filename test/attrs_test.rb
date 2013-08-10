require 'minitest/autorun'
require 'attrs'

class Person < Attrs(:name, :age)
  private

  def age=(new_age)
    super(new_age.to_i)
  end
end

class PersonTest < Minitest::Spec
  let(:valid_attributes) { {name: "John Doe", age: 26} }
  let(:klass) { Person }

  it "responds to .attribute_names" do
    klass.attribute_names.must_equal [:name, :age]
  end

  it "can be instantiated" do
    klass.new(valid_attributes).must_be_kind_of klass
  end

  it "has string representation" do
    str = klass.new(valid_attributes).inspect
    str.must_equal "#<#{klass} #{valid_attributes.inspect}>"
  end

  it "must be instantiated with all attributes" do
    proc {
      klass.new(age: 26)
    }.must_raise KeyError
  end

  it "can access individual attributes" do
    klass.new(valid_attributes).name.must_equal "John Doe"
  end

  it "can return all attributes" do
    klass.new(valid_attributes).attributes.must_equal valid_attributes
  end

  it "can overwrite setting of an attribute" do
    klass.new(valid_attributes.merge(age: '26')).age.must_equal 26
  end

  it "cannot mutate attributes" do
    person = klass.new(valid_attributes)

    proc {
      person.name = 'Joe'
    }.must_raise NoMethodError
  end

  it "is equal to an object with the same attributes" do
    klass.new(valid_attributes).must_equal klass.new(valid_attributes)

    klass.new(valid_attributes).must_equal valid_attributes
  end

  it "is equal to hash of the same attributes" do
    klass.new(valid_attributes).must_equal valid_attributes
  end
end

require 'attrs/coercible'

class Person2 < Attrs(name: String, age: Integer)
end

class Person2Test < PersonTest
  let(:klass) { Person2 }
end
