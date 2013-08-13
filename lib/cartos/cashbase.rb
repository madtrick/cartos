require "csv"
module Cartos
  module Cashbase
    def self.importer=(importer)
      @importer = importer
    end

    #def self.load(data)
    def self.load
      data_array = CSV.parse @importer.import
      data_array.shift #Remove header row
      entries = data_array.inject([]) do |acc, row|
        if row[4].force_encoding('UTF-8') == Cartos.config.cashbasehq.account_name
          entry = Cartos::Cashbase::Entry.new
          date_string = row[0].split("-")
          entry.date = Time.new date_string[0], date_string[1], date_string[2]
          entry.amount = row[1].to_f
          entry.category = row[2]
          entry.description = row[3]
          acc << entry
        else
          acc
        end
      end

      collection = Collection.new
      collection.elements = entries
      collection
    end
    class Collection
      attr_accessor :elements

      def categories
        result = self.elements.inject([]) do |memo, element|
           memo << element.category
        end

        result.uniq
      end

      def size
        self.elements.size
      end

      def filter_by_year(year)
        self.elements.select! do |element|
          element.date.year == year
        end
        self
      end

      def each_month(&block)
        months_hash = self.elements.inject({}) do |memo, element|
          (memo[element.date.month] ||= []) << element
          memo
        end

        months_hash.each_pair do |month, elements|
          collection = self.class.new
          collection.elements = elements
          yield month, collection
        end
      end

      def each_category(&block)
        categories_hash = self.elements.inject({}) do |memo, element|
          (memo[element.category] ||= []) << element
          memo
        end

        categories_hash.each_pair do |category, elements|
          collection = self.class.new
          collection.elements = elements
          yield category, elements
        end
      end

      def filter_by_month(month)
        self.elements.select! do |element|
          element.date.month == month
        end
        self
      end

      def each(&block)
        self.elements.each &block if block_given?
      end

      def to_a
        self.elements
      end
    end


    class Entry
      attr_accessor :date, :amount, :description, :category
    end
  end
end
