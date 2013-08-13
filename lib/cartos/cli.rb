require "cartos/generators/config"
require "thor"

module Cartos
  class CLI < Thor
    desc "init", "Creates an empty $HOME/.cartos.yml config file"
    def init
      Cartos::Generators::Config.start
    end
  end
end
