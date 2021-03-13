FROM node:lts

RUN apt-get -qqq update

RUN apt-get install -y -qqq postgresql-client

RUN npm install -g @dawadk/replication-client

RUN useradd --system dawa-replicator

WORKDIR /app

RUN mkdir config

COPY config.json config/

RUN chown -R dawa-replicator /app/config \
    && chmod -R 700 /app/config

COPY wrapper.sh .
RUN chown dawa-replicator wrapper.sh \
    && chmod 700 wrapper.sh

USER dawa-replicator

ENTRYPOINT ["bash", "./wrapper.sh"]
