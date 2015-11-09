#!/bin/bash
source ../html/shared/db_config.cfg

MUSER="$db_updates_user"
MPASS="$db_updates_password"
MDB="$db_updates_name"

# Detect paths
MYSQL=$(which mysql)
AWK=$(which awk)
GREP=$(which grep)

TABLES=$($MYSQL -u $MUSER -p$MPASS $MDB -e 'show tables' | $AWK '{ print $1}' | $GREP -v '^Tables' )

for t in $TABLES
do
	echo "Deleting $t table from $MDB database..."
	$MYSQL -u $MUSER -p$MPASS $MDB -e "drop table $t"
done
