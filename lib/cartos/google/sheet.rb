module Cartos
  module Google
    class Sheet

      class Formulas
        def initialize
          @buffer = []
        end
        def sum(*numbers)
          @buffer.unshift ["SUM", numbers]
          self
        end

        def filter(sourceArray, *conditions)
          @buffer.unshift ["FILTER", [sourceArray, conditions]]
          self
        end

        def abs(number = nil)
          @buffer.unshift ["ABS", number]
          self
        end

        def unique(array)
          @buffer.unshift ["UNIQUE", array]
        end

        def to_s
          result = @buffer.inject("") do |memo, element|
            name, *params = *element
            params = params.flatten.compact
            if params.empty?
              memo = "#{name}(#{memo})"
            else
              memo = "#{name}(#{params.join(",")})"
            end
            memo
          end
          "=" + result
        end
      end

      ALPHABET = "A".upto("Z").to_a

      def initialize(sheet)
        @sheet = sheet
        @last_rows = {}
      end

      def push_row(column, value)
        column_number = ensure_column_as_number column
        result = set_row (self.last_row column), column_number, value
        result
      end

      def set_row(row, column, value)
        @sheet[row, column] = value
        @last_rows[column] = row + 1
        [row, column]
      end

      def last_row(column)
        @last_rows[ensure_column_as_number column] ||= 1
      end

      def save
        @sheet.save
      end

      def column_letter_to_integer(column)
        ALPHABET.index(column) + 1
      end

      def row_range(column, first, last)
        "#{column}#{first}:#{column}#{last}"
      end

      private
        def ensure_column_as_number(column)
          case column
          when String
            column_letter_to_integer column
          when Fixnum
            column
          end
        end
    end
  end
end
