require "spec_helper"

RSpec.describe Psql::Json::Serializer do
  it "has a version number" do
    expect(Psql::Json::Serializer::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
