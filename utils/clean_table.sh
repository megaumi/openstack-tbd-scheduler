#!/bin/bash

NUM_TO_KEEP=$1
NUM_TO_DELETE=`mysql -u$NOVA_USERNAME -p$NOVA_PASSWORD --skip-column-names -s vmstats -e "SELECT COUNT(*) - 2 from vmpcpustats);"`
mysql -u$NOVA_USERNAME -p$NOVA_PASSWORD vmstats -e "DELETE FROM vmpcpustats ORDER BY date LIMIT '$NUM_TO_DELETE';"
mysql -u$NOVA_USERNAME -p$NOVA_PASSWORD vmstats -e "SELECT * FROM vmpcpustats;"