# RubyCleverbot [![Gem Version](https://badge.fury.io/rb/ruby_cleverbot.svg)](https://badge.fury.io/rb/ruby_cleverbot)

A simple gem to talk with CleverBot

**Cleverbot is now offering an official Cleverbot API at www.cleverbot.com/api. This gem wont be updated anymore.**

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby_cleverbot'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby_cleverbot

## Usage

```ruby
require 'ruby_cleverbot'

c = RubyCleverbot.new('HelloBot')

puts c.send_message('hi') #=> "Hello."
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

