# Attrs

[![Build Status](https://secure.travis-ci.org/wojtekmach/attrs.png?branch=master)](http://travis-ci.org/wojtekmach/attrs)

Yet another attributes on steroids gem.

Heavily inspired by [Virtus](https://github.com/solnic/virtus) and
[Values](https://github.com/tcrayford/Values) which both are great projects.

The purpose of this project is to have a small & simple codebase and minimum number of features.
For a more complex solution I strongly recommend **Virtus** which I'm happily using in production.

## Features

* immutability
* all attributes must be specified on initialisation. Hopefully less `nil`'s flying around
* uses `attr_reader` and `attr_writer`. Can be easily overwritten
* just ~50 LOC (not including coercion support)
* no external dependencies (again, not counting coercion which requires coercible gem)

## Usage

Let's write a `Person` class:

```ruby
require 'attrs'

class Person < Attrs(:name, :age)
  private

  def default_name
    "Anonymous"
  end

  def age=(new_age)
    super(new_age.to_i)
  end
end

person = Person.new(name: 'John Doe', age: '26')
```

with this code we can:

* get the attributes hash:    `person.attributes      # => {:name => "John Doe", :age => 26}`
* get the attribute names:    `Person.attribute_names # => [:name, :age]`
* compare with other objects: `person == {:name => "John Doe", :age => 26} # => true`
* Explicitly set default values: `Person.new(age: 26).name # => "Anonymous"

and more! See: <https://github.com/wojtekmach/attrs/blob/master/test/attrs_test.rb>

### Coercion

Notice in previous example we added custom `age=` writer to coerce argument to integer.

One of my favourite features of **Virtus** is attribute coercion, and you can use it here too.
In fact it's using the same library that was extracted out from **Virtus**: <https://github.com/solnic/coercible>

```
gem install coercible
```

```ruby
require 'attrs/coercible'

class Person < Attrs(name: String, age: Integer)
end
```

or, simply:

```ruby
Person = Attrs(name: String, age: Integer)
```

(note, using 2nd style you won't be able to use `super` when overwriting methods)

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
