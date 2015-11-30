#!/bin/bash
#Create Symlinks from Current files to Shared files

# where am i? move to where I am. This ensures source is properly sourced
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

#cd to current release
cd -P ../html/current

#cd sites
cd sites

#cd to each folder
#sym link files dir to shared files
#return to sites

cd accounts
ln -s ../../../../shared/accounts_files files
cd ..

cd default
ln -s ../../../../shared/default_files files
cd ..

cd digital
ln -s ../../../../shared/digital_files files
cd ..

cd housing
ln -s ../../../../shared/housing_files files
cd ..
