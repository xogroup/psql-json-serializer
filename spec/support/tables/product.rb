module Tables
  class Product
    def self.primary_key
      "id"
    end

    def self.name
      "products"
    end

    def self.columns
      [
        FakeRecord::Column.new('id', :integer),
        FakeRecord::Column.new('price', :decimal)
      ]
    end
  end
end
