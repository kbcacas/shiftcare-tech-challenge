RSpec.describe 'ShiftCare CLI' do
  let(:cli) { 'ruby bin/cli.rb' }

  it 'searches by name from remote JSON' do
    output = `#{cli} search smith`
    expect(output.downcase).to include('smith')
  end

  it 'prints duplicate emails' do
    output = `#{cli} duplicates`
    expect(output.downcase).to include('duplicate')
  end
end
