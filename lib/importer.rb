module Cartos
  class Importer
    def self.import(source = nil)
      @importer = importer_for_source(source).new
      @importer.import source
    end

    def self.importer_for_source(source)
      return Cartos::Import::File unless source.nil?
      return Cartos::Import::Cashbase
    end
  end
end
