require 'sinatra/base'
require 'sprockets'
require 'sass'
require 'json'
require 'securerandom'
require 'uri'
require 'dotenv/load'
require_relative 'services/url_service'


class App < Sinatra::Base
  set :url, 'itty.be'
  set :environment, Sprockets::Environment.new
  environment.append_path("assets/stylesheets")
  environment.append_path("assets/javascripts")

  get '/' do
    erb :index
  end

  post '/shorten', provides: :json do
    pass unless request.accept? 'application/json'
    long_url = JSON.parse(request.body.read)["url"]
    long_url = "http://#{long_url}" unless long_url.start_with? "http"
    begin
      # Check URL validity
      URI.parse(long_url)

      # Create short link
      url_service = UrlService.new
      short_path = url_service.create(long_url)
      short_url = "http://itty.be/#{short_path}"

      res = {
        url: {
          long: long_url,
          short: short_url
        }
      }.to_json
      [200, {}, res]
    rescue URI::InvalidURIError
      res = {
        error: {
          url: "#{params[:url]}",
          message: 'The format of this url appears invalid.'
        }
      }.to_json
      [400, {}, res]
    end
  end

  get '/terms' do
    erb :terms
  end

  get '/privacy' do
    erb :privacy
  end

  get "/assets/*" do
    env["PATH_INFO"].sub!("/assets", "")
    settings.environment.call(env)
  end

  get '/:short_path' do
    url_service = UrlService.new
    long_url = url_service.read(params[:short_path])
    if long_url.nil?
      halt 404
    else
      redirect long_url
    end
  end
end
