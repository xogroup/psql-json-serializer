module Tables
  class User
    def self.primary_key
      "id"
    end

    def self.name
      "users"
    end

    def self.columns
      [
        FakeRecord::Column.new("id", :integer),
        FakeRecord::Column.new("name", :string),
        FakeRecord::Column.new("bool", :boolean),
        FakeRecord::Column.new("created_at", :date),
        FakeRecord::Column.new("updated_at", :date),
        FakeRecord::Column.new("mobile_phone_number", :string),
        FakeRecord::Column.new("home_phone_number", :string)
      ]
    end
  end
end
