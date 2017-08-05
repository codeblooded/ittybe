require 'spec_helper'

RSpec.describe 'GET /privacy' do
  it 'returns successfully' do
    get '/privacy'
    expect(last_response).to be_ok
  end
end
