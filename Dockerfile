FROM debian:9.7-slim

RUN apt-get update \
  && apt-get install -y git \
  && apt-get install -y wget \
  && apt-get install -y curl \
  && apt-get -y install sudo \
  && apt-get -y install php7.2 php-ext-mbstring php-ext-simplexml  \
  && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -

RUN apt-get install -y nodejs
RUN npm install -g yarn

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY *.sh /
RUN chmod +x /*.sh

ENTRYPOINT ["/entrypoint.sh"]
