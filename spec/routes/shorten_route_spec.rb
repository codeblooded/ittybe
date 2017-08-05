require 'spec_helper'

RSpec.describe 'POST /shorten' do
  let(:invalid_long_url) { 'foo barr buzz' }
  let(:valid_long_url) { 'https://bitbucket.org/benvreed' }
  let(:correct_headers) { { 'Content-Type': 'application/json'} }

  context 'passed valid JSON body and URL' do
    it 'returns a 200' do
      post '/shorten', { url: valid_long_url}.to_json, correct_headers
      expect(last_response.status).to eq(200)
    end
  end

  context 'passed invalid JSON body' do
    it 'returns a 400' do
      post '/shorten', '{foo = bar, "cat": true}', correct_headers
      expect(last_response.status).to eq(400)
    end
  end

  context 'passed invalid URL' do
    it 'returns a 400' do
      post '/shorten', { url: invalid_long_url }.to_json, correct_headers
      expect(last_response.status).to eq(400)
    end
  end
end
