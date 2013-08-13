require "sugarfree-config"
require "logging"
require "cartos/version"

include Logging.globally
Logging.logger.root.appenders = Logging.appenders.stdout
Logging.logger.root.level     = :info

module Cartos
  autoload :Cashbase    , "cartos/cashbase"
  autoload :Import      , "cartos/import/import"
  autoload :Google      , "cartos/google/google"
  autoload :Spreadsheet , "cartos/spreadsheet/spreadsheet"

  def self.config=(config)
    @config = config
  end

  def self.config
    @config
  end

  def self.load_from_cashbase
    Cartos::Cashbase.importer = Cartos::Import::Cashbase.new
    Cartos::Cashbase.load
  end

  def self.load_from_file(filename)
    importer = Cartos::Import::File.new filename
    Cartos::Cashbase.importer = importer
    Cartos::Cashbase.load
  end

  self.config = SugarfreeConfig.init env: 'config', file: File.expand_path("~/.cartos.yml"), reload: false
end

