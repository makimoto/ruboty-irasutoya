require "open-uri"
require "nokogiri"

module Ruboty
  module Handlers
    class Irasutoya < Base

      SEARCH_ENDPOINT = "http://www.irasutoya.com/search?q="

      on(
        /irasuto(?:ya)?(?:\s+(.*))?/,
        name: 'irasutoya',
        description: 'show irasuto from irasutoya'
      )

      def irasutoya(message)
        keyword = message.match_data[1]
        nokogiri = Nokogiri::HTML(open("#{SEARCH_ENDPOINT}#{URI.escape(keyword)}"))
        result = nokogiri.xpath("//div[@class='boxim']/a").to_a.sample
        if result
          message.reply(result.attr('href'))
        else
          message.reply('ಠ_ಠ')
        end
      end
    end
  end
end
