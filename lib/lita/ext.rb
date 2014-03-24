require "lita/ext/version"
require "lita/ext/core"
require "lita/ext/handler"

# Make sure we are in the Lita root directory
Dir.chdir(Lita.root)

# Add 'lib' directory to the load path.
lib = File.expand_path('lib', Lita.root)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Load initializers.
initializers = "#{Lita.root}/config/initializers/**/*.rb"
Dir.glob(initializers).each { |initializer| require initializer }

# Load app handlers
handlers = "#{Lita.root}/app/handlers/**/*.rb"
Dir.glob(handlers).each { |handler| require handler }

# Auto-register app handlers.
Lita::Handler.handlers.each do |handler|
  unless handler.disabled?
    Lita.register_handler(handler)
  end
end

# Load the environment specific settings
environment = "#{Lita.root}/config/environments/#{Lita.env}"
if File.exists?("#{environment}.rb")
  require environment
end
