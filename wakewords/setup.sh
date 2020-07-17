#!/bin/bash
export PGPASSWORD=$DB_PASSWORD
psql -h db -d mycroft -U selene -f /setup/WAKEWORDS.sql
