$:.unshift File.dirname(__FILE__)

require "lib/cartos"

task :load, :filename do |t, args|
  entries = if (args[:filename])
              Cartos.load_from_file File.absolute_path(args[:filename])
            else
              Cartos.load_from_cashbase
            end
  entries.filter_by_year 2012
  spread_sheet = Cartos::Spreadsheet::CartosSpreadsheet.new Cartos.config.google_spreadsheet.key
  spread_sheet.monthly entries
  spread_sheet.summary entries
end
