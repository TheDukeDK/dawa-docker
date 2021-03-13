FROM node:lts

RUN apt-get -qqq update && apt-get install -y -qqq postgresql-client && \
  rm -rf /var/lib/apt/lists/*

RUN npm install -g @dawadk/replication-client

RUN useradd --system dawa-replicator

WORKDIR /app

COPY config.json .

COPY wrapper.sh .
RUN chown dawa-replicator wrapper.sh config.json \
    && chmod 700 wrapper.sh

USER dawa-replicator

ENTRYPOINT ["bash", "./wrapper.sh"]
