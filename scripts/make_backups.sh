#wombattesting

source db_config.cfg

now=$(date +"%Y-%m-%d-%s")

sudo tar -zcvpf backups/$db_name-$now.tar.gz html/

mysqldump -u $db_user -p $db_name > backups/$db_name-$now.sql

sudo tar -zcvpf backups/$db_name-$now.sql.tar.gz backups/$db_name-$now.sql

rm backups/$db_name-$now.sql
