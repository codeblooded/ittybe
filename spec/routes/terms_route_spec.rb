require 'spec_helper'

RSpec.describe 'GET /terms' do
  it 'returns successfully' do
    get '/terms'
    expect(last_response).to be_ok
  end
end
