require 'json'
require 'httparty'
require_relative 'client'

module ShiftCare
  class ClientStore
    CLIENTS_URL = 'https://appassets02.shiftcare.com/manual/clients.json'

    attr_reader :clients

    def initialize
      response = HTTParty.get(CLIENTS_URL)

      if response.code == 200
        raw_data = JSON.parse(response.body)
        @clients = raw_data.map { |attrs| Client.new(attrs) }
      else
        puts "Failed to fetch clients. Status: #{response.code}"
        @clients = []
      end
    rescue HTTParty::Error => e
      puts "HTTP error: #{e.message}"
      @clients = []
    rescue JSON::ParserError => e
      puts "JSON parsing error: #{e.message}"
      @clients = []
    end
  end
end
