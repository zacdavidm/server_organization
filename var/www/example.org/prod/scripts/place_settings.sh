#!/bin/bash
#Symlink Shared Settings Files to Current Sites Folders

# where am i? move to where I am. This ensures source is properly sourced
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

#cd to current release
cd -P ../html/current

#cd sites
cd sites

#cd to each folder
#sym link settings files to shared settings files
#return to sites

cd accounts
ln -s ../../../../shared/settings.accounts.php settings.php
cd ..

cd default
ln -s ../../../../shared/settings.default.php settings.php
cd ..

cd digital
ln -s ../../../../shared/settings.digital.php settings.php
cd ..

cd housing
ln -s ../../../../shared/settings.housing.php settings.php
cd ..
