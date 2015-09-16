# Server Organization
Describe ideal server structure and functionality.

Starting working directory is `/var/www` followed by the domain name, including tld.

```
/var/www
/var/www/example.org:
```

Inside this domain directory is a number of environments, each self contained with it's accompanyment of backups, html, logs, and scripts directories.

##PROD:
Primary live site. needs to have a cron running to auto backup the site every
few days. There needs to be some abiltiy to create a copy of prod when
branching or updating.

```
prod
prod/backups
prod/html
prod/logs
prod/scripts
```

##STAGING:
This is the staging environment. It is the auto deployment of the master branch.
This is the last testing environment before deploying to prod. It should have
scripts run periodically to exactly copy prod db and content to it so there is
an identical testing environment for merging.

```
staging
staging/backups
staging/html
staging/logs
staging/scripts
```

##DEVX[1,2,3...]:
These are the development environments. They are where branches are deployed and tested. When these are branched from prod they should receive an exact copy of
the DB and file systems (uploads).

```
devx
devx/backups
devx/html
devx/logs
devx/scripts
```

##UPDATE:
This environment is just for running updates on the prod system. It should have
a cron running on it to once a week pull in the master repo, as well as files
and DB and run the update script on it and send an email out. After the site has
been visually reviewed and approved the code can be re-merged to the master
branch and the database updates can be run safely without fear of breaking.

```
update
update/backups
update/html
update/logs
update/scripts
```
