module FakeRecord
  class ConnectionPool
    class Spec < Struct.new(:config)
    end

    attr_reader :spec, :connection

    def initialize
      @spec = Spec.new(:adapter => "america")
      @connection = Connection.new
      @connection.visitor = Arel::Visitors::ToSql.new(connection)
    end

    def with_connection
      yield connection
    end

    def table_exists? name
      connection.tables.include? name.to_s
    end

    def columns_hash
      connection.columns_hash
    end

    def schema_cache
      connection
    end

    def quote thing
      connection.quote thing
    end
  end
end
