require 'minitest/autorun'
require 'attrs'

class Person < Attrs(:name, :age)
  private

  def age=(new_age)
    super(new_age.to_f)
  end
end

describe "Class with Attrs" do
  let(:valid_attributes) { {name: "John Doe", age: 26} }

  it "responds to .attribute_names" do
    Person.attribute_names.must_equal [:name, :age]
  end

  it "can be instantiated" do
    Person.new(valid_attributes).must_be_kind_of Person
  end

  it "must be instantiated with all attributes" do
    proc {
      Person.new(age: 26)
    }.must_raise KeyError
  end

  it "can access individual attributes" do
    Person.new(valid_attributes).name.must_equal "John Doe"
  end

  it "can return all attributes" do
    Person.new(valid_attributes).attributes.must_equal valid_attributes
  end

  it "can overwrite setting of an attribute" do
    Person.new(valid_attributes.merge(age: '26')).age.must_equal 26
  end

  it "cannot mutate attributes" do
    person = Person.new(valid_attributes)

    proc {
      person.name = 'Joe'
    }.must_raise NoMethodError
  end

  it "is equal to an object with the same attributes" do
    Person.new(valid_attributes).must_equal Person.new(valid_attributes)

    Person.new(valid_attributes).must_equal valid_attributes
  end

  it "is equal to hash of the same attributes" do
    Person.new(valid_attributes).must_equal valid_attributes
  end
end
