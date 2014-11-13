FROM        phusion/baseimage:0.9.15
MAINTAINER  Guilhem Berna <gberna@phosphore.eu>

ENV HOME /root
CMD ["/sbin/my_init"]


RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y postgresql-9.3 postgresql-contrib-9.3

USER postgres

ENV ROOT_USER docker
ENV ROOT_PASSWORD docker

RUN    /etc/init.d/postgresql start &&\
psql --command "update pg_database set datallowconn = TRUE where datname = 'template0';" &&\
psql --command "\c template0" &&\
psql --command "update pg_database set datistemplate = FALSE where datname = 'template1';" &&\
psql --command "drop database template1;" &&\
psql --command "create database template1 with template = template0 encoding = 'UTF8';" &&\
psql --command "update pg_database set datistemplate = TRUE where datname = 'template1';" &&\
psql --command "\c template1" &&\
psql --command "update pg_database set datallowconn = FALSE where datname = 'template0';" &&\
psql --command "CREATE USER ${ROOT_USER} WITH SUPERUSER PASSWORD '${ROOT_PASSWORD}';" &&\
/etc/init.d/postgresql stop


# Adjust PostgreSQL configuration so that remote connections to the
# database are possible. 
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf

RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

USER root

# Postgree daemon
RUN mkdir /etc/service/postgresql
ADD run_postgresql.sh /etc/service/postgresql/run
RUN chmod +x /etc/service/postgresql/run
# Expose the postgre port
#EXPOSE 5432

VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]


# Add my public keys
ADD pubkeys /tmp/pubkeys
RUN cat /tmp/pubkeys/*.pub >> /root/.ssh/authorized_keys && rm -rf /tmp/pubkeys/
EXPOSE 22

# Clean up for smaller image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

