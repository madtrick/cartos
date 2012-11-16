require "httparty"
module Cartos
  module Import
    class Cashbase
      include HTTParty
      base_uri "https://www.cashbasehq.com"

      def import
        signin
        response = self.class.get "/export_all/csv"
        response.body
      end

      private
      def signin
        resp = self.class.get ""
        cookies = resp.headers["set-cookie"]
        match = cookies.match /PHPSESSID=([\w\d]+);/
        sessid = match[1]
        self.class.cookies :PHPSESSID => sessid
        self.class.post "/signin", {:body => {:email => Cartos.config.cashbasehq.username, :password => Cartos.config.cashbasehq.password}}
      end
    end
  end
end
