require 'redis'

module RedisHelper
  def redis
    @redis ||= Redis.new(url: ENV['REDIS_URL'])
  end
end
