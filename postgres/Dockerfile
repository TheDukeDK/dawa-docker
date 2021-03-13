ARG POSTGIS_VERSION=13-3.1

FROM postgis/postgis:$POSTGIS_VERSION

RUN localedef -i da_DK -c -f UTF-8 -A /usr/share/locale/locale.alias da_DK.UTF-8
ENV LANG da_DK.utf8

COPY create-schema.sql /docker-entrypoint-initdb.d/
