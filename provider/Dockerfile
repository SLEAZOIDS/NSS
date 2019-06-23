# Railsコンテナ用Dockerfile

FROM ruby:2.6.2

ENV LANG C.UTF-8

RUN apt-get update -qq \
&& apt-get install -y build-essential \ 
&& rm -rf /var/lib/apt/lists/*

# yarnパッケージ管理ツールをインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn
# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
apt-get install nodejs

RUN gem install bundler

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
ADD . $APP_HOME
WORKDIR $APP_HOME

RUN yarn install