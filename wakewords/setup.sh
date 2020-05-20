#!/bin/bash
psql -h db -d mycroft -U selene -f /setup/WAKEWORDS.sql

