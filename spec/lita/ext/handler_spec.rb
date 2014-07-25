require 'spec_helper'

describe Lita::Handler, lita: true do
  let(:robot) { instance_double("Lita::Robot", name: "Lita") }
  let(:user) { instance_double("Lita::User", name: "Test User") }

  let(:handler_class) do
    Class.new(described_class) do
      config :foo
      config :bar, required: false
      config :baz, default: "default value"

      def self.name
        "FooHandler"
      end
    end
  end

  subject { handler_class.new(robot) }

  it "auto-registers Lita::Handler sub-classes" do
    class TestHandler < Lita::Handler
    end
    Lita::Ext::Core.new.send(:register_app_handlers)
    expect(Lita.handlers).to include(TestHandler)
  end

  describe '.config_options' do
    it "contains specified configuration options" do
      expect(handler_class.config_options.length).to eq(3)
    end
  end

  describe '.config' do
    before do
      allow(Lita).to receive(:handlers).and_return([subject])
      Lita::Config.load_user_config
    end

    it "defaults to required" do
      foo_option = handler_class.config_options.select { |opt| opt.name == :foo }.first
      expect(foo_option.required?).to eq(true)
    end

    it "required option can be used to make a config setting optional" do
      bar_option = handler_class.config_options.select { |opt| opt.name == :bar }.first
      expect(bar_option.required?).to eq(false)
    end

    # TODO: figure out how to initialize the handler's config object properly
    # it "can accept a default value for the config setting" do
    #   baz_option = handler_class.config_options.select { |opt| opt.name == :baz }.first
    #   expect(baz_option.default).to eq("default value")
    #   expect(subject.config[:baz]).to eq("default value")
    # end
  end

  describe '#log' do
    it "returns the Lita logger" do
      expect(subject.log).to eq(Lita.logger)
    end
  end

  describe '#config' do
    it "returns the handler's config object" do
      expect(subject.config).to eq(Lita.config.handlers.foo_handler)
    end

    # TODO: figure out how to initialize the handler's config object properly
    # it "contains options specified with Lita::Handler.config" do
    #   exepect(subject.config.baz).to eq("default value")
    # end
  end
end
