FROM node:20-bookworm-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends git wget curl ca-certificates openssh-client \
  && rm -rf /var/lib/apt/lists/*

RUN corepack enable

COPY *.sh /
RUN chmod +x /*.sh

ENTRYPOINT ["/entrypoint.sh"]
