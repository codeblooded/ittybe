FROM ruby:2.4.1-alpine

MAINTAINER Ben Reed <https://github.com/codeblooded>

ENV REDIS_URL=redis://redis_db:6379

RUN apk update && apk upgrade
RUN apk add --update alpine-sdk
RUN apk add ruby-bundler

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install --system

COPY . /app
RUN bundle install --system

EXPOSE 9292

CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0"]
