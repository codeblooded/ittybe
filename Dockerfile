FROM ruby:2.4.1-alpine

ENV REDIS_URL=redis://redis_db:6379

RUN apk update && apk upgrade
RUN apk add --update alpine-sdk
RUN apk add ruby-bundler

WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install --system

ADD . /app
RUN bundle install --system

EXPOSE 9292

CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0"]