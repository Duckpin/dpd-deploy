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

COPY *.sh /
RUN chmod +x /*.sh
RUN pwd
RUN ls -l
ENTRYPOINT ["/entrypoint.sh"]
