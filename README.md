# Lita::Ext

Lita::Ext adds a number of extensions to [Lita](https://www.lita.io/) to
make it more Rails like. It adds the concept of multiple environments,
Rails like initializers, and provides structure for your Lita handlers.

The layout of a Lita::Ext bot:

    .
    ├── Gemfile
    ├── Gemfile.lock
    ├── README.md
    ├── Rakefile
    ├── app
    │   └── handlers
    │       └── echo.rb
    ├── config
    │   ├── environments
    │   │   ├── development.rb
    │   │   ├── production.rb
    │   │   └── testing.rb
    │   └── initializers
    │       └── initialize_foo.rb
    ├── lib
    │   └── custom_lib.rb
    ├── lita_config.rb
    └── log
        └── lita.log

Following the Rails conventions, your bot's handlers go in `app/handlers`
and environment specific settings are in `config/environments`. Initializers
are placed in `config/initializers` and are used to initialize a library or
setup global variables before the bot starts.

The `lib` folder is used for code that isn't a handler or initializer.
For example, a helper script for accessing a web service that is used by
a handler. The `lib` folder is added to the `$LOAD_PATH` but you must
`require` files that you want to use.

## Installation

Add this line to your application's Gemfile:

    gem 'lita-ext'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lita-ext

## Usage

### Startup Process

TODO: describe startup process

### `Lita` extensions

TODO: describe extensions to the base Lita module

    Lita.env => "development"
    Lita.env.development? => true

    Lita.root => "/path/to/lita/bot"

### `Lita::Handler` extensions

TODO: `#log`, `#config`, etc.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
