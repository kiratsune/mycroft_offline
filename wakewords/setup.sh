#!/bin/bash
export PGPASSWORD=$DBPASSWORD
if [! -f /shared/wakewordSetupDone ]; then
    while [ ! -f /shared/db_bootstrap_done ]; do
        echo "Waiting for db bootstrap script to termiante..."
        sleep 3
    done
    psql -h db -d mycroft -U selene -f /setup/WAKEWORDS.sql && touch /shared/wakewordSetupDone
fi
