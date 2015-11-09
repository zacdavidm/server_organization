#!/bin/bash

cd ../html/current

git checkout master

git pull origin master

git merge --no-ff updates

git push origin master
