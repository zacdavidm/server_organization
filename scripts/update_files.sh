#!/bin/bash

#delete current file directories
rm -rf ../html/shared/accounts_files
rm -rf ../html/shared/default_files
rm -rf ../html/shared/digital_files
rm -rf ../html/shared/housing_files

#cp -r files from prod shared to updates shared
cp -r ../../prod/html/shared/accounts_files ../html/shared/accounts_files
cp -r ../../prod/html/shared/default_files ../html/shared/default_files
cp -r ../../prod/html/shared/digital_files ../html/shared/digital_files
cp -r ../../prod/html/shared/housing_files ../html/shared/housing_files

#make sure symbolic links are set
if ! [ -L ../html/current/sites/accounts/files ]; then
echo "accounts files symlink doesn't exist. creating..."
ln -s ../../../shared/accounts_files ../html/current/sites/accounts/files
fi
if ! [ -L ../html/current/sites/default/files ]; then
echo "default files symlink doesn't exist. creating..."
ln -s ../../../shared/default_files ../html/current/sites/default/files
fi
if ! [ -L ../html/current/sites/digital/files ]; then
echo "digital files symlink doesn't exist. creating..."
ln -s ../../../shared/digital_files ../html/current/sites/digital/files
fi
if ! [ -L ../html/current/sites/housing/files ]; then
echo "housing files symlink doesn't exist. creating..."
ln -s ../../../shared/housing_files ../html/current/sites/housing/files
fi
