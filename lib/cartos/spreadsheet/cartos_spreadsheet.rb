module Cartos
  module Spreadsheet
    class CartosSpreadsheet
      def initialize(spreeadsheet_key)
        @spreadsheet =  Cartos::Google::Spreadsheet.new spreeadsheet_key
        logger.info "Exporting data to #{@spreadsheet.url}"
      end


      def monthly(entries)
        entries.each_month do |month, month_entries|
          new_month month, month_entries
        end
      end

      def summary(entries)
        summary_sheet = Cartos::Spreadsheet::Summary.new @spreadsheet.new_sheet "summary"
        categories = {}
        totals = {}
        totals["expendings"] = {}
        totals["earnings"] = {}
        totals["total"] = {}
        entries.each_month do |month, month_entries|
          totals["expendings"][month] = 0
          totals["earnings"][month] = 0
          month_entries.each do |entry|
            entry.amount < 0 ? totals["expendings"][month] += entry.amount : totals["earnings"][month] += entry.amount
          end
          totals["total"][month] = totals["earnings"][month] + totals["expendings"][month]
          totals["expendings"][month] = totals["expendings"][month]
          month_entries.each_category do |category, elements|
            categories[category] ||= {}
            categories[category][month] = elements.inject(0) {|total, element| total += element.amount}
          end
        end
        summary_sheet.push_categories categories
        summary_sheet.push_totals totals
        summary_sheet.save
      end

      private
        def new_month(month, entries)
          month_sheet = Cartos::Spreadsheet::Month.new @spreadsheet.new_sheet month.to_s
          entries.each do |entry|
            month_sheet.push_entry entry.date.strftime("%F"), entry.amount, entry.description, entry.category
          end

          entries.categories.each do |category|
            month_sheet.push_category category
          end

          earnings_total, expendings_total = 0, 0
          entries.each do |entry|
            if entry.amount > 0
              earnings_total += entry.amount
            else
              expendings_total += entry.amount
            end
          end
          month_sheet.push_summary expendings_total, earnings_total

          month_sheet.save
        end
    end
  end
end
