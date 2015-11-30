source config.cfg

now=$(date +"%Y-%m-%d-%s")

sudo tar -zcvpf ../backups/$db_name-$now.tar.gz ../html/shared

mysqldump --user="$db_user" --password="$db_password" $db_name > ../backups/$db_name-$now.sql

sudo gzip ../backups/$db_name-$now.sql
