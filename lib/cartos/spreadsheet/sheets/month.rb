module Cartos
  module Spreadsheet
    class Month
      DATE        = "A"
      AMOUNT      = "B"
      DESCRIPTION = "C"
      CATEGORY    = "D"

      CATEGORIES  = "F"
      EXPENDINGS_BY_CATEGORY = "G"

      EARNINGS_TOTAL = "F"
      EXPENDINGS_TOTAL = "G"

      def initialize(sheet)
        @sheet = sheet
      end

      def push_entry(date, amount, description, category)
        push_row DATE, date
        push_row AMOUNT, amount
        push_row DESCRIPTION, description
        push_row CATEGORY, category
      end

      def push_category(category)
        push_row CATEGORIES, category
        formula        = Cartos::Google::Sheet::Formulas.new
        entry_range    = @sheet.row_range(AMOUNT, 1, @sheet.last_row(AMOUNT))
        category_range = @sheet.row_range(CATEGORY, 1, @sheet.last_row(CATEGORY))
        push_row EXPENDINGS_BY_CATEGORY, formula.sum.filter(entry_range, "#{category_range} = \"#{category}\"")
      end

      def push_summary(expendings_total, earnings_total)
        push_row EARNINGS_TOTAL, "Earnings"
        push_row EARNINGS_TOTAL, earnings_total
        push_row EXPENDINGS_TOTAL, "Expendings"
        push_row EXPENDINGS_TOTAL, expendings_total
      end

      def push_row(column, value)
        @sheet.push_row column, value
      end

      def save
        @sheet.save
      end

      private
    end
  end
end
