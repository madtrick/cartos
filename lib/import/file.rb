require "csv"

module Cartos
  module Import
    class File
      def initialize(filename)
        @filename = filename
      end
      def import
        puts "Importing data from file #{@filename}"
        file = ::File.open @filename
        file.read
      end
    end
  end
end
