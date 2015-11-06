#!/bin/bash

#use unaliased version to overwrite files.
\cp ../html/shared/settings.accounts.php ../html/current/sites/accounts/settings.php
\cp ../html/shared/settings.default.php ../html/current/sites/default/settings.php
\cp ../html/shared/settings.digital.php ../html/current/sites/digital/settings.php
\cp ../html/shared/settings.housing.php ../html/current/sites/housing/settings.php

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
