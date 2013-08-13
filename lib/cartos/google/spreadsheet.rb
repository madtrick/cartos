require "google_drive"

module Cartos
  module Google
    class Spreadsheet
      def initialize(key)
        @session = GoogleDrive.login Cartos.config.google_spreadsheet.username, Cartos.config.google_spreadsheet.password
        @spreadsheet = @session.spreadsheet_by_key key
      end

      def new_sheet(name)
        worksheet = @spreadsheet.worksheet_by_title name.to_s
        worksheet.delete unless worksheet.nil?

        worksheet = @spreadsheet.add_worksheet name
        Cartos::Google::Sheet.new worksheet
      end

      def url
        @spreadsheet.human_url
      end
    end
  end
end
