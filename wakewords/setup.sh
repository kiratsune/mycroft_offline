#!/bin/bash
export PGPASSWORD=$DB_PASSWORD
if [ ! -f /shared/wakewordSetupDone ]; then
    while [ ! -f /shared/db_bootstrap_done ]; do
        echo "Waiting for db bootstrap script to terminate..."
        sleep 3
    done
    psql -h db -d mycroft -U selene --no-password -f /setup/WAKEWORDS.sql && touch /shared/wakewordSetupDone
fi
