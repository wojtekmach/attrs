# Attrs

Yet another attributes on steroids gem.

Heavily inspired by [Virtus](https://github.com/solnic/virtus) which totally rocks.

## Features

* immutability
* all attributes must be specified on initialisation
* uses basically `attr_reader` and `attr_writer`. Can be easily overwritten
* just 50 LOC.

## Usage

Let's write a `Person` class:

```ruby
class Person < Attrs(:name, :age)
  private

  def age=(new_age)
    super(new_age.to_f)
  end
end

person = Person.new(name: 'John Doe', age: '26')
```

with this code we can:

* get the attributes hash:    `person.attributes      # => {:name => "John Doe", :age => 26}`
* get the attribute names:    `Person.attribute_names # => [:name, :age]`
* compare with other objects: `person == {:name => "John Doe", :age => 26} # => true`

and more! See: <https://github.com/wojtekmach/attrs/blob/master/test/attrs_test.rb>

## Installation

Add this line to your application's Gemfile:

    gem 'attrs'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attrs

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
