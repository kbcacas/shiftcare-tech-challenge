require 'rspec'
require_relative '../lib/shiftcare/client'
require_relative '../lib/shiftcare/searcher'

RSpec.describe ShiftCare::Searcher do
  let(:clients) do
    [
      ShiftCare::Client.new({ 'id' => 1, 'full_name' => 'John Doe', 'email' => 'john@example.com' }),
      ShiftCare::Client.new({ 'id' => 2, 'full_name' => 'Jane Smith', 'email' => 'jane@example.com' }),
      ShiftCare::Client.new({ 'id' => 3, 'full_name' => 'Johnny Walker', 'email' => 'john@example.com' })
    ]
  end

  describe '.search_by_name' do
    it 'returns matches for partial name' do
      result = described_class.search_by_name(clients, 'john')
      expect(result.size).to eq(2)
      expect(result.map(&:full_name)).to contain_exactly('John Doe', 'Johnny Walker')
    end

    it 'is case-insensitive' do
      result = described_class.search_by_name(clients, 'JANE')
      expect(result.map(&:full_name)).to include('Jane Smith')
    end

    it 'returns empty array if no matches' do
      result = described_class.search_by_name(clients, 'Michael')
      expect(result).to be_empty
    end
  end

  describe '.find_duplicate_emails' do
    it 'returns duplicate emails with associated clients' do
      result = described_class.find_duplicate_emails(clients)
      expect(result).to have_key('john@example.com')
      expect(result['john@example.com'].size).to eq(2)
    end

    it 'returns empty hash if no duplicates' do
      unique_clients = clients.select { |c| c.email != 'john@example.com' }
      result = described_class.find_duplicate_emails(unique_clients)
      expect(result).to be
