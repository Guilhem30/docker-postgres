FROM        guilhem30/sudokeys
MAINTAINER  Guilhem Berna <gberna@phosphore.eu>

ENV HOME /root
CMD ["/sbin/my_init"]

ENV LC_ALL en_US.UTF-8
RUN locale-gen --no-purge ${LC_ALL}
RUN update-locale LANG=${LC_ALL}
RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -yq postgresql-9.3 postgresql-contrib-9.3

USER postgres

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible. 
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf

RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

USER root

# Postgree daemon
RUN mkdir /etc/service/postgresql
ADD run_postgresql.sh /etc/service/postgresql/run
RUN chmod +x /etc/service/postgresql/run

RUN touch firstrun

# Expose the postgre port
# EXPOSE 5432

VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Clean up for smaller image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

