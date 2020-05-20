#!/bin/bash
CURRENT_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
source ${CURRENT_DIR}/helpers
parseconf

export DB_PASSWORD=$(cat ${MYCROFT_CREDENTIALS_DIR}/selene_postgres_password)
docker run -it --rm --net mycroft_offline_default -e PGPASSWORD=$DB_PASSWORD --entrypoint=/setup/setup.sh -v ${CURRENT_DIR}'/../wakewords:/setup' postgres:12.1
