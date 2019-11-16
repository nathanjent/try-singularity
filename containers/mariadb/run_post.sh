#!/bin/sh

# cd into the folder of the script
here="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $here

mysql_install_db
mysqld_safe --datadir=/var/lib/mysql &
