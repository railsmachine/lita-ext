require 'lita'
require 'dotenv'
require 'active_support'
require 'active_support/core_ext/module/aliasing'

module Lita
  class << self
    def env
      @env ||= ActiveSupport::StringInquirer.new(ENV['LITA_ENV'] || 'development')
    end

    def root
      @root ||= ENV['LITA_ROOT'] ||= File.expand_path('.')
    end
  end

  module Ext
    class Core
      def self.call(payload)
        chdir_to_lita_root
        load_dotenv
        add_lib_to_load_path
        load_initializers
        load_app_handlers
        register_app_handlers
        load_environment_config
      end

      private

      def chdir_to_lita_root
        Dir.chdir(Lita.root)
      end

      def load_dotenv
        Dotenv.load ".env.#{Lita.env}", '.env'
      end

      def add_lib_to_load_path
        lib = File.expand_path('lib', Lita.root)
        $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
      end

      def load_initializers
        initializers = "#{Lita.root}/config/initializers/**/*.rb"
        Dir.glob(initializers).each { |initializer| require initializer }
      end

      def load_app_handlers
        handlers = "#{Lita.root}/app/handlers/**/*.rb"
        Dir.glob(handlers).each { |handler| require handler }
      end

      def register_app_handlers
        Lita::Handler.handlers.each do |handler|
          unless handler.disabled?
            Lita.register_handler(handler)
          end
        end
      end

      def load_environment_config
        environment = "#{Lita.root}/config/environments/#{Lita.env}"
        if File.exists?("#{environment}.rb")
          require environment
        end
      end
    end

    Lita.register_hook(:before_run, Core)
  end
end
