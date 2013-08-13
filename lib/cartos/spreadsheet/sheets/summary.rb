module Cartos
  module Spreadsheet
    class Summary < Sheet
      TOTALS = "A"
      CATEGORIES = "A"

      def initialize(sheet)
        super sheet
        @last_col_used = 1
        @month_cols = {}
        @category_row = {}
      end

      def push_totals(totals)
        row, _ = push_row TOTALS, "Totals"
        push_summnary row, TOTALS, totals
      end
      def push_categories(categories)
        row, _ = push_row CATEGORIES, "Categories"
        push_summnary row, CATEGORIES, categories
      end



      private

        def push_summnary(start_row, type_column, elements)
          push_months start_row, elements.values.map {|v| v.keys}.flatten.uniq
          elements.each do |element, months|
            row, column = push_row type_column, element
            months.each do |month, amount|
              push_month_amount  month, row, amount
            end
          end
        end

        def push_month_amount(month, row, amount)
          set_row row, col_for_month(month), amount
        end

        def push_months(row,months)
          months.each do |month|
            set_row row, col_for_month(month), month
          end
        end

        def col_for_month(month)
          if @month_cols[month].nil?
            @month_cols[month] = @last_col_used + 1
            @last_col_used += 1
          end

          @month_cols[month]
        end
    end
  end
end
