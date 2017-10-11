require "psql/json/serializer/version"
require "arel"

module Psql
  module Json
    module Serializer
      class Base
        def initialize(table_name)
          @table = Arel::Table.new(table_name)
        end

        def select_all
          @query = @table.project(Arel.star)

          self
        end

        def select_as(attr, new_name)
          @query = @query.project(@table[attr].as(new_name))

          self
        end

        def select_formatted_date(attr, format, name = attr)
          to_char = date_node(attr, format)
          @query = @query.project(to_char.as(name))

          self
        end

        def select_first_present(*attrs)
          options = attrs.map { |a| @table[a] }
          node = Arel::Nodes::NamedFunction.new("COALESCE", options)
          node = yield(node) if block_given?
          @query = @query.project(node)

          self
        end

        def select_first_date_present(*attrs, format)
          options = attrs.map { |a| date_node(a, format) }
          node = Arel::Nodes::NamedFunction.new("COALESCE", options)
          node = yield(node) if block_given?
          @query = @query.project(node)

          self
        end

        def date_node(attr, format)
          format_node = Arel::Nodes::Quoted.new(format)
          Arel::Nodes::NamedFunction.new("TO_CHAR", [@table[attr], format_node])
        end

        def to_sql
          @query.to_sql
        end
      end
    end
  end
end
