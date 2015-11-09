#!/bin/bash

#run this file with cron weekly on thursdays

#reset database, files, branches, etc

#empty database
source drop_tables.sh

#copy database from prod to updates
source copy_prod_db.sh

#change to git directory
cd ../html

#remove branch
rm -rf current/

#re-clone
git clone git@github.com:zacdavidm/forgood_io.git

#rename directory
mv forgood_io current

#move into git directory
cd current

#update all our submodules
git submodule update --init --recursive

#switch to master
git checkout master

#delete remotely
git push origin --delete updates

#delete locally
git branch -d updates

#update master
git pull origin master

#update all modules recursively
git submodule update --init --recursive

#branch master to updates
git checkout -b updates

#update all modules recursively
git submodule update --init --recursive

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

#add any new files for commit
git add -A

git commit -am "drush run drupal updates";

#button to reintegrate updates back into master
echo "if everything looks ok, reintegrate to master"
#echo shell script to run
echo "run ./commit_updates.sh"
#link to staging site and update script
echo "then run drush database update for forgoodstaging.dev"
