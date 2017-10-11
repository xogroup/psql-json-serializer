module FakeRecord
  class Connection
    attr_reader :tables
    attr_accessor :visitor

    def initialize(visitor = nil)
      @columns = {}
      @columns_hash = {}
      @primary_keys = {}
      @tables = []

      Tables.constants
        .select {|c| Tables.const_get(c).is_a? Class }
        .map {|c| Tables.const_get(c) }
        .each do |table|

        @tables.push(table.name)
        @columns[table.name] = table.columns
        @columns_hash[table.name] = Hash[@columns[table.name].map { |x| [x.name, x] }]
        @primary_keys[table.name] = table.primary_key
      end

      @visitor = visitor
    end

    def columns_hash table_name
      @columns_hash[table_name]
    end

    def primary_key name
      @primary_keys[name.to_s]
    end

    def data_source_exists? name
      @tables.include? name.to_s
    end

    def columns name, message = nil
      @columns[name.to_s]
    end

    def quote_table_name name
      "\"#{name.to_s}\""
    end

    def quote_column_name name
      "\"#{name.to_s}\""
    end

    def schema_cache
      self
    end

    def quote thing, other
      case thing
      when DateTime
        "'#{thing.strftime("%Y-%m-%d %H:%M:%S")}'"
      when Date
        "'#{thing.strftime("%Y-%m-%d")}'"
      when true
        "'t'"
      when false
        "'f'"
      when nil
        'NULL'
      when Numeric
        thing
      else
        "'#{thing.to_s.gsub("'", "\\\\'")}'"
      end
    end
  end
end
