#!/bin/sh

# cd into the folder of the script
here="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $here

#sudo singularity exec --writable-tmpfs -B data/:/var/lib/mysql mariadb.sif mysql_install_db
#sudo singularity exec --writable-tmpfs -B data/:/var/lib/mysql mariadb.sif mysqld_safe --datadir=/var/lib/mysql &
#sudo singularity exec --writable-tmpfs -B data/:/var/lib/mysql mariadb.sif mysql --user=root <<_EOF_
#-- UPDATE mysql.user SET Password=PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User='root';
#SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PASSWORD}') ;
#-- DELETE FROM mysql.user WHERE User='';
#-- DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
#DELETE FROM mysql.user WHERE user NOT IN ('mysql.sys', 'mysqlxsys', 'root') OR host NOT IN ('localhost') ;
#DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
#GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION ;
#FLUSH PRIVILEGES;
#DROP DATABASE IF EXISTS test;
#_EOF_
#
#sudo singularity exec --writable-tmpfs -B data/:/var/lib/mysql mariadb.sif \
#if [ -n "$MYSQL_DATABASE" ]; then
#    mysql --user=root --password=$MYSQL_ROOT_PASSWORD "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` ;"
#fi
#
#singularity exec --writable-tmpfs -B data/:/var/lib/mysql mariadb.sif \
#if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_PASSWORD" ]; then
#    mysql --user=root --password=$MYSQL_ROOT_PASSWORD "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" 
#
#    if [ -n "$MYSQL_DATABASE" ]; then
#        mysql --user=root --password=$MYSQL_ROOT_PASSWORD "GRANT ALL ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%' ;"
#    fi
#    mysql --user=root --password=$MYSQL_ROOT_PASSWORD "FLUSH PRIVILEGES ;"
#fi
