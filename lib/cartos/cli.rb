require "cartos"
require "cartos/generators/config"
require "thor"

module Cartos
  class CLI < Thor
    desc "init", "Creates an empty $HOME/.cartos.yml config file"
    def init
      Cartos::Generators::Config.start
    end

    desc "export", "Export data to Google Spreadsheet"
    option :file, aliases: "-f", desc: "Path to file which contains a Cashbase export"
    option :year, aliases: "-y", type: :numeric, required: true, desc: "Year used to filter the entries that will be exported to Google"
    def export
      entries = if (options[:file])
                  Cartos.load_from_file File.absolute_path(options[:file])
                else
                  Cartos.load_from_cashbase
                end
      entries.filter_by_year options[:year]
      spread_sheet = Cartos::Spreadsheet::CartosSpreadsheet.new Cartos.config.google_spreadsheet.key
      spread_sheet.monthly entries
      spread_sheet.summary entries
    end
  end
end
