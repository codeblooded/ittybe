require 'spec_helper'
require 'securerandom'

RSpec.describe 'GET /:short_path' do
  let(:valid_long_url) { 'http://itty.be/privacy' }
  let(:url_service) { UrlService.new }
  let(:random_uuid) { SecureRandom.uuid }

  context 'passed existing short_path' do
    it 'redirects to the appropriate long_url' do
      short_path = url_service.create(valid_long_url)
      get "/#{short_path}"
      expect(last_response.status).to eq(302)

      follow_redirect!
      expect(last_response.body).to include('Privacy Policy')
    end
  end

  context 'passed non-existing short_path' do
    it 'returns a 404' do
      get "/#{random_uuid}"
      expect(last_response.status).to eq(404)
    end
  end
end
