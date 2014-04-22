require 'thor'
require 'lita'
require 'lita/cli'
require 'lita/ext'

module Lita
  module Ext
    class CLI < Thor
      include Thor::Actions

      # The root path for the templates directory.
      # @note This is a magic method required by Thor for file operations.
      # @return [String] The path.
      def self.source_root
        File.expand_path("../../../../templates", __FILE__)
      end

      desc "new NAME", "Create a new Lita bot named NAME (default name: lita)"
      def new(name = "lita")
        directory "robot", name
      end

      desc "handler NAME", "Create a new app handler named NAME"
      def handler(name)
        config = {}
        config[:handler_name] = name.split(/_/).map { |p| p.capitalize }.join
        target = File.join(Lita.root, "app/handlers/#{name}.rb")
        template("handler.tt", target, config)
      end
    end
  end
end
