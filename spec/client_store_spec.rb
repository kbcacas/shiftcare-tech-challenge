require_relative '../lib/shiftcare/client_store'

RSpec.describe ShiftCare::ClientStore do
  let(:url) { 'https://appassets02.shiftcare.com/manual/clients.json' }

  it 'loads clients from the default URL' do
    store = ShiftCare::ClientStore.new(url: url)
    expect(store.clients).to all(be_a(ShiftCare::Client))
    expect(store.clients).not_to be_empty
  end

  it 'handles bad URLs gracefully' do
    store = ShiftCare::ClientStore.new(url: 'https://invalid.url/fake.json')
    expect(store.clients).to eq([])
  end
end
