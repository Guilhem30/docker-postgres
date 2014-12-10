#!/bin/sh
set -e

su postgres -c "/usr/lib/postgresql/9.3/bin/postgres -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf &"
sleep 2
if [ -f /firstrun ]
then
        rm /firstrun
        echo "postgres is running for the first time, creating root account."
        USER=${USER:-root}
        PASS=${PASS:-$(pwgen -s -1 16)}
        su postgres -c "psql --command \"CREATE USER $USER WITH SUPERUSER PASSWORD '${PASS}';\""
        echo "POSTGRES_USER=$USER"
        echo "POSTGRES_PASS=$PASS"
fi


# Script should not exit unless postgre died
while pgrep -f "postgre" 2>&1 >/dev/null; do
        sleep 10;
done

exit 1

