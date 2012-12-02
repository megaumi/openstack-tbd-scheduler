#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: clean_table.sh number"
    exit
fi

set -x
NUM_TO_KEEP=$1
NUM_TO_DELETE=`mysql -u$NOVA_USERNAME -p$NOVA_PASSWORD --skip-column-names -s vmstats -e "SELECT COUNT(*) - $NUM_TO_KEEP from vmpcpustats;"`
mysql -u$NOVA_USERNAME -p$NOVA_PASSWORD vmstats -e "DELETE FROM vmpcpustats ORDER BY date LIMIT $NUM_TO_DELETE;"
mysql -u$NOVA_USERNAME -p$NOVA_PASSWORD vmstats -e "SELECT * FROM vmpcpustats;"
