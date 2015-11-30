#!/bin/bash
#Re-Synchronize the DB from Prod (change to parent)

# where am i? move to where I am. This ensures source is properly sourced
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

#prod config
source ../../prod/html/scripts/config.cfg

db_prod_user=$db_user
db_prod_password=$db_password
db_prod_name=$db_name

#self config
source config.cfg

db_self_user=$db_user
db_self_password=$db_password
db_self_name=$db_name

mysqldump --user="$db_prod_user" --password="$db_prod_password" $db_prod_name | mysql --user="$db_self_user" --password="$db_self_password" $db_self_name
