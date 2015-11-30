#!/bin/bash
#Drop All Tables in the Database
source config.cfg

tables_array=$(mysql --user="$db_user" --password="$db_password" $db_name -e 'show tables' | awk '{ print $1}' | grep -v '^Tables' )

for table in $tables_array
do
	echo "Deleting $table table from $db_name database..."
	mysql --user="$db_user" --password="$db_password" $db_name -e "drop table $table"
done
