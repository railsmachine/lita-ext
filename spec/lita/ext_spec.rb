require 'spec_helper'

describe Lita do
  describe '.env' do
    it "defaults to 'development'" do
      expect(described_class.env).to eq('development')
    end
  end

  describe '.root' do
    it "equals cwd" do
      expect(described_class.root).to eq(File.expand_path('../../../', __FILE__))
    end
  end
end
