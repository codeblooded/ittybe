require 'redis'
require 'securerandom'

class UrlService

  def create(long_url)
    short_path = generate_short_path
    redis.hmset(short_path, :long_url, long_url, :view_count, 0)
    short_path
  end

  def read(short_path)
    redis.hincrby(short_path, :view_count, 1)
    redis.hget(short_path, :long_url)
  end

  def destroy(short_path)
    redis.del(short_path)
  end

  private

  def redis
    @redis ||= Redis.new(url: ENV['REDIS_URL'])
  end

  def generate_short_path
    short_path = ""
    loop do
      short_path = make_alpha_numeric_string
      break unless redis.exists(short_path)
    end

    short_path
  end

  def make_alpha_numeric_string
    length = short_path_character_set.length
    Array.new(5) { short_path_character_set[SecureRandom.random_number(length)] }.join("")
  end

  def short_path_character_set
    @short_path_character_set ||= [*'a'..'z'] + [*'0'..'9']
  end
end
