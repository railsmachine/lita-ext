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
    │   │   └── staging.rb
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

Lita::Ext performs serveral actions at startup that make it easier for you
to focus on writing custom handlers for your bot. The `Lita.run` method
performs the following additional actions:

1. Change directory to the `Lita.root` directory.
2. Load [Dotenv](https://github.com/bkeepers/dotenv) settings for the bot.
Like the dotenv-rails gem, Lita::Ext will load both the standard `.env`
file as well as environment specific settings in `.env.#{Lita.env}`.
3. Add the `lib` directory to the load path.
4. Load initializers in the `config/initializers` directory.
5. Load your bot's custom handlers from the `app/handlers` directory.
6. Auto-register your bot's handlers so that you don't have to call
`Lita.register_handler(MyCustomHandler)` for each handler.
7. Load the environment specific settings from
`config/environments/#{Lita.env}.rb`.

### Lita module extensions

Lita::Ext provides two new methods to the base `Lita` module.

#### Lita.env

The `Lita.env` method will return the current Lita environment. The
environment is set with the `LITA_ENV` environment variable and defaults
to `"development"` when not set. The Lita environment will determine which
environment configuration to load form the `config/environments` directory
and which Dotenv settings file to load. Environments can be used to run
different adapters for development, staging, and production. For example,
you can use the shell adapter for the development environment and the
[Campfire adapter](https://github.com/josacar/lita-campfire) in production.

Examples:

    Lita.env => "development"
    Lita.env.development? => true

#### Lita.root

The `Lita.root` method returns the path to the root directory for your
Lita bot. It is useful for loading setting files relative to the bot's
root directory. By default the root directory is determined by the
current working directory, but it can be overridden with the `LITA_ROOT`
environment variable.

Examples:

    Lita.root => "/path/to/lita/bot"

### Lita::Handler extensions

Lita::Ext provides several convenience methods to the default
`Lita::Handler` class. The `#log` method provides shorter access to Lita
logger at `Lita.logger`. The `#config` method provides direct access to
the handler's configuration options. The `Lita::Handler.config` class
method makes it easy to specify configuration settings for the handler.
The `#config_valid?` method returns true if all required configuration
options are set and false otherwise.

Example:

    class MyCustomHandler < Lita::Handler
      config :api_token
      config :foo, default: "bar", required: false

      route /^foo/, :foo, command: true

      def foo(response)
        if config_valid?
          # Do something with config.api_token
          ...
        else
          response.reply "Missing foo API token"
        end
      end
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

***

Unless otherwise specified, all content copyright &copy; 2014, [Rails Machine, LLC](http://railsmachine.com)
