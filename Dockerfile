FROM ruby:3.2.2-bullseye

WORKDIR /app

COPY ["Gemfile", "Gemfile.lock", "/app"]
RUN bundle install --jobs=4

COPY [".", "/app"]

