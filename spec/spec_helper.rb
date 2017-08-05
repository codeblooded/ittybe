require 'rack/test'
require_relative '../app'
require_relative '../services/redis_helper'

ENV['APP_ENV'] = 'test'

module SinatraRspecMixin
  include Rack::Test::Methods
  include RedisHelper

  def app
    App
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include SinatraRspecMixin
end
