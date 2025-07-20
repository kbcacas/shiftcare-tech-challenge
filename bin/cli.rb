#!/usr/bin/env ruby

require_relative '../lib/shiftcare/client_store'
require_relative '../lib/shiftcare/searcher'

def print_usage
  puts "Usage:"
  puts "  ruby bin/cli.rb search <query>"
  puts "  ruby bin/cli.rb duplicates"
end

if ARGV.empty?
  print_usage
  exit
end

command = ARGV[0]
client_store = ShiftCare::ClientStore.new

case command
when 'search'
  query = ARGV[1]
  if query.nil?
    puts "Search query required."
    print_usage
    exit
  end
  results = ShiftCare::Searcher.search_by_name(client_store.clients, query)
  if results.empty?
    puts "No clients found matching '#{query}'"
  else
    results.each { |client| puts "#{client.full_name} - #{client.email}" }
  end
when 'duplicates'
  duplicates = ShiftCare::Searcher.find_duplicate_emails(client_store.clients)
  if duplicates.empty?
    puts "No duplicates found."
  else
    duplicates.each do |email, clients|
      puts "\nDuplicate email: #{email}"
      clients.each { |client| puts "- #{client.full_name}" }
    end
  end
else
  puts "Invalid command: #{command}"
  print_usage
end
