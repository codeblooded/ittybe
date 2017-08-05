require 'spec_helper'
require 'redis'
require_relative '../../services/url_service'

RSpec.describe UrlService do
  subject { UrlService.new }
  let(:long_url) { 'http://facebook.com/benvreed' }
  let(:short_path) { subject.create(long_url) }

  context 'shortening a url' do
    it 'returns a non-nil short_path' do
      short_path = subject.create(long_url)
      expect(short_path).not_to be_nil
    end

    it 'returns an appropriately sized short_path when a custom length is specified' do
      short_path_length = 10
      actual_short_path = subject.create(long_url, short_path_length)
      expect(actual_short_path.length).to eq(short_path_length)
    end

    it 'sets an appropriate hash in redis' do
      response = redis.hmget(short_path, :long_url).first
      expect(response).to eq(long_url)
    end
  end

  context 'reading a shortened url' do
    it 'increments the view count' do
      2.times { subject.read(short_path) }
      actual_view_count = redis.hmget(short_path, :view_count).first.to_i
      expect(actual_view_count).to eq(2)
    end

    it 'returns the long url' do
      response = subject.read(short_path)
      expect(response).to eq(long_url)
    end
  end

  context 'deleting a shortened url' do
    it 'removes the key from redis' do
      subject.destroy(short_path)
      expect(redis.exists(short_path)).to be_falsey
    end
  end
end
