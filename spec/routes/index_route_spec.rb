require 'spec_helper'

RSpec.describe 'GET /' do
  it 'returns successfully' do
    get '/'
    expect(last_response).to be_ok
  end
end
