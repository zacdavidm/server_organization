#!/bin/bash

#run this file with cron weekly on thursdays

#reset database, files, branches, etc

#empty database
source drop_tables.sh

#copy database from prod to updates
source copy_prod_db.sh

#change to git directory
cd ../html/current
#reset branch
#switch to master
git checkout master

#delete remotely
git push origin --delete updates

#delete locally
git branch -d updates

#update master
git pull origin master

#branch master
git checkout -b updates

#return to scripts dir
cd ../../scripts

#remove files and cp new files from prod
source update_files.sh

#copy settings files into proper dirs
source update_settings_files.sh

#move to drupal dir for drush
cd ../html/current

#run drush update script
drush @sites pm-updatecode -y
drush @sites updatedb -y

##take selenium screenshots

#email notification for review

git commit -am "drush run drupal updates";

#button to reintegrate updates back into master
echo "if everything looks ok, reintegrate to master"
#link to staging site and update script
echo "then run drush database update for forgoodstaging.remote"
