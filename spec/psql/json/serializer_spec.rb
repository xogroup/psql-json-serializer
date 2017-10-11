require "spec_helper"
require "arel"

RSpec.describe Psql::Json::Serializer do
  it "has a version number" do
    expect(Psql::Json::Serializer::VERSION).not_to be nil
  end
end
