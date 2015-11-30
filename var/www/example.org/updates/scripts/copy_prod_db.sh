#!/bin/bash

#prod config
source ../../prod/html/shared/config.cfg

#self/updates config
source ../html/shared/config.cfg

mysqldump -h 'localhost' -u $db_prod_user -p$db_prod_password $db_prod_name | mysql -h 'localhost' -u $db_updates_user -p$db_updates_password $db_updates_name
