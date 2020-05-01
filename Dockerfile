FROM ruby:2.6.3

RUN apt update \
        && apt-get install build-essential curl gnupg apt-utils -y

RUN curl -sL https://deb.nodesource.com/setup_11.x  | bash -
RUN apt-get -y install nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt update &&  apt install yarn -y

# install latest ImageMagick
RUN wget https://imagemagick.org/download/ImageMagick.tar.gz \
        && tar xvzf ImageMagick.tar.gz \
        && cd ImageMagick-7.* \
        && ./configure \
        && make \
        && make install \
        && ldconfig /usr/local/lib \
        && magick -version
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem install bundler
RUN bundle install
RUN yarn install --check-files
COPY . /app

## Add a script to be executed every time the container starts.
#COPY entrypoint.sh /usr/bin/
#RUN chmod +x /usr/bin/entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]