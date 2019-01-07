FROM ruby:2.5.3-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN mkdir -p /app/tmp/pids \
  && mkdir -p /app/vendor \
  && mkdir -p /app/log

WORKDIR /app

ADD Gemfile Gemfile.lock ./

RUN \
  apk update && apk add --no-cache \
    git \
    build-base && \
  bundle install --deployment --without development:test:doc && \
  apk del \
    git \
    build-base

ADD ./server.rb ./server.rb
