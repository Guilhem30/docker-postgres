#!/bin/sh

su postgres -c "/usr/lib/postgresql/9.3/bin/postgres -D /var/lib/postgresql/9.3/main -c config_file=/etc/postgresql/9.3/main/postgresql.conf"

# Script should not exit unless postgre died
while pgrep -f "postgre" 2>&1 >/dev/null; do
        sleep 10;
done

exit 1

