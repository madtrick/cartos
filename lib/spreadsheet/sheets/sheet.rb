module Cartos
  module Spreadsheet
    class Sheet
      def initialize(sheet)
        @sheet = sheet
      end

      def push_row(column, value)
        @sheet.push_row column, value
      end

      def set_row(column, row, value)
        @sheet.set_row column, row, value
      end

      def save
        @sheet.save
      end
    end
  end
end
