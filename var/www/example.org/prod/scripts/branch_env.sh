#!/bin/bash
#Branch Current Environment to New Environment

# where am i? move to where I am. This ensures source is properly sourced
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

#accept input of new environment
branch_name="$1"

if [ "$branch_name" = "" ]; then
  echo "Need to enter an environent directory name as an argument."
  exit 1
fi

if [ -d "../../$branch_name" ]; then
  # Control will enter here if $DIRECTORY exists.
  echo "That directory already exists. Please try again with new one or remove directory."
  exit 2
fi

#copy database
source config.cfg

db_source_name=$db_name
db_source_user=$db_user
db_source_password=$db_password

source ../../config.cfg

db_base_name=$db_name

db_dest_name="${db_base_name}_$branch_name"

RESULT=`mysql --user="$db_source_user" --password="$db_source_password" -e "SHOW DATABASES" | grep -Fo $db_dest_name`
 if [ "$RESULT" == "$db_dest_name" ]; then
   echo "That database already exists. Please try again with new name or remove database."
   exit 3
 fi

# CREATE DATABASE duplicateddb;

#MySQL Dump
mysqldump --user="$db_source_user" --password="$db_source_password" $db_source_name > mysql_tmp_dump_transfer.sql

#MySQL Create DB
mysql --user="$db_source_user" --password="$db_source_password" -e "CREATE DATABASE $db_dest_name"

#MySQL Import
mysql --user="$db_source_user" --password="$db_source_password" $db_dest_name < mysql_tmp_dump_transfer.sql

#remove DB dump file
rm mysql_tmp_dump_transfer.sql

#create environment (use environment script?)
mkdir ../../$branch_name
mkdir ../../$branch_name/html

#copy shared files over
#cp -r current_files new_files
cp -r ../html/shared ../../$branch_name/html/shared

#update settings.php files
sed -i "/^[ \t]*\*/! {/'database'/s/'\([^']*\)'/'$db_dest_name'/2}" ../../$branch_name/html/shared/settings.accounts.php

sed -i "/^[ \t]*\*/! {/'database'/s/'\([^']*\)'/'$db_dest_name'/2}" ../../$branch_name/html/shared/settings.default.php

sed -i "/^[ \t]*\*/! {/'database'/s/'\([^']*\)'/'$db_dest_name'/2}" ../../$branch_name/html/shared/settings.digital.php

sed -i "/^[ \t]*\*/! {/'database'/s/'\([^']*\)'/'$db_dest_name'/2}" ../../$branch_name/html/shared/settings.housing.php


#copy scripts over
cp -r . ../../$branch_name/scripts

#update config.cfg lines (copy over most fields)
sed -i "/db_name/s/=.*/=\"$db_dest_name\"/" ../../$branch_name/scripts/config.cfg

new_domain="${host_prefix}$branch_name"

#TODO switch this to not exists
if [ ! -d "/etc/httpd/sites-available/" ]; then
  # Control will enter here if $DIRECTORY exists.
  echo "The virtual hosts directory does not exist or exists in an alternate location. Please place the following in a file in your appropriate virtual hosts directory."

  echo
"<VirtualHost *:80>
  ServerName www.$new_domain.dev
  ServerAlias $new_domain.dev accounts.$new_domain.dev housing.$new_domain.dev digital.$new_domain.dev
  DocumentRoot /var/www/$www_dir/$branch_name/html/current
  ErrorLog /var/www/$www_dir/$branch_name/logs/error.log
  <Directory /var/www/$www_dir/$branch_name/html/current>
    AllowOverride All
  </Directory>
</VirtualHost>"

else
  touch /etc/httpd/sites-available/$host_prefix$branch_name.conf

  #create virtual hosts pointing to new environment
  echo "<VirtualHost *:80>
    ServerName www.$new_domain.dev
    ServerAlias $new_domain.dev accounts.$new_domain.dev housing.$new_domain.dev digital.$new_domain.dev
    DocumentRoot /var/www/$www_dir/$branch_name/html/current
    ErrorLog /var/www/$www_dir/$branch_name/logs/error.log
    <Directory /var/www/$www_dir/$branch_name/html/current>
      AllowOverride All
    </Directory>
  </VirtualHost>" > /etc/httpd/sites-available/$host_prefix$branch_name.conf

  ln -s /etc/httpd/sites-available/$host_prefix$branch_name.conf /etc/httpd/sites-enabled/$host_prefix$branch_name.conf
fi

ip_addr="$(ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')"

#echo out hosts file lines
echo "Enter the following lines in your /etc/hosts file"
echo "#$host_prefix - $branch_name environment start"
echo "$ip_addr www.$new_domain.dev $new_domain.dev accounts.$new_domain.dev housing.$new_domain.dev digital.$new_domain.dev"
echo "#$host_prefix - $branch_name environment end"
echo ""
echo "You will need to restart apache for the virtual hosts to take place. You can do that with the following command:"
echo "sudo service httpd restart"
