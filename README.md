# Rails Console

Now you can connect into your Rails Console directly from project folder!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'railsconsole'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install railsconsole

## Usage

### Configuring

```ruby
require 'rails_console'

RailsConsole.setup do |config|
  # you can set a different path of deploy file
  config.deploy_file = 'config/mydeploy.rb'
end
```

### Simple usage
```ruby
require 'rails_console'

RailsConsole.connection
```

### Connecting to your rails console directly from project folder

After install railsconsole on your environment, run this script:

```console
$ railsconsole
Loading production environment (Rails 5.2.1)
irb(main):001:0>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/formaweb/railsconsole.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
