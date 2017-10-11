require "spec_helper"
require "arel"

RSpec.describe Psql::Json::Serializer::Base do
  subject { described_class.new(:users) }

  it "selects all attributes" do
    expect(subject.select_all.to_sql).to eq("SELECT * FROM \"users\"")
  end

  it "select as attributes" do
    sql = subject
      .select_all
      .select_as('name', 'user_name')
      .to_sql

    expect(sql).to eq("SELECT *, \"users\".\"name\" AS user_name FROM \"users\"")
  end

  it "select date attributes" do
    sql = subject
      .select_all
      .select_formatted_date('created_at', 'MM-DD-YYYY')
      .to_sql

    expect(sql).to eq("SELECT *, TO_CHAR(\"users\".\"created_at\", 'MM-DD-YYYY') AS created_at FROM \"users\"")
  end

  it "select first present attribute" do
    sql = subject
      .select_all
      .select_first_present(
        'mobile_phone_number',
        'home_phone_number') { |n| n.as('phone_number') }
      .to_sql

    expect(sql).to eq("SELECT *, COALESCE(\"users\".\"mobile_phone_number\", \"users\".\"home_phone_number\") AS phone_number FROM \"users\"")
  end

  it "select first date present" do
    sql = subject
      .select_all
      .select_first_date_present(
        'updated_at',
        'created_at',
        'MM-DD-YYYY') { |n| n.as('last_updated_at') }
      .to_sql

    expect(sql).to eq("SELECT *, COALESCE(TO_CHAR(\"users\".\"updated_at\", 'MM-DD-YYYY'), TO_CHAR(\"users\".\"created_at\", 'MM-DD-YYYY')) AS last_updated_at FROM \"users\"")
  end
end
