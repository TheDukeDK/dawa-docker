FROM postgis/postgis:9.5-3.0
RUN localedef -i da_DK -c -f UTF-8 -A /usr/share/locale/locale.alias da_DK.UTF-8
ENV LANG da_DK.utf8

ADD ./init /docker-entrypoint-initdb.d/