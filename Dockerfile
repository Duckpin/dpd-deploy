FROM debian:9.7-slim

RUN apt-get update \
  && apt-get install -y git \
  && apt-get install -y wget \
  && apt-get install -y curl \
  && apt-get -y install sudo \
  && rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash -

RUN apt-get install -y nodejs
RUN npm install -g yarn

RUN apt-get -y install php7.2 php-cli php-ext-mbstring php-ext-simplexml php7.2-common php7.2-opcache php7.2-mcrypt php7.2-cli php7.2-gd php7.2-curl php7.2-mysql
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

COPY *.sh /
RUN chmod +x /*.sh

ENTRYPOINT ["/entrypoint.sh"]
