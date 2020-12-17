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

LABEL org.opencontainers.image.source="https://github.com/MilesChou/composer-action" \
    repository="https://github.com/MilesChou/composer-action" \
    maintainer="MilesChou <jangconan@gmail.com>"

RUN set -xe && \
    apt-get install --no-cache \
        git \
        unzip

ENV COMPOSER_ALLOW_SUPERUSER=1 \
    COMPOSER_MEMORY_LIMIT=-1 \
    COMPOSER_HOME=/tmp \
    COMPOSER_PATH=/usr/bin/composer \
    COMPOSER_VERSION=1.10.5

COPY --from=composer:1.10.5 /usr/bin/composer /usr/bin/composer

RUN set -xe && \
        composer self-update --1 && \
        composer global require hirak/prestissimo && \
        composer clear-cache

COPY *.sh /
RUN chmod +x /*.sh

ENTRYPOINT ["/entrypoint.sh"]
