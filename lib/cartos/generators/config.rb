require "thor/group"

module Cartos
  module Generators
    class Config < Thor::Group
      include Thor::Actions

      def self.source_root
        File.dirname(__FILE__) + "/config"
      end

      def copy_config
        template("config.yml", "#{File.expand_path "~"}/.cartos.yml")
      end
    end
  end
end
