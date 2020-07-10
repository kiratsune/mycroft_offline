#!/bin/bash

# Usage: generate_password_file dir filename env_var_name bytes underscore_in_output_password_if_empty
# Will not regenerate a file if it's already there
generate_password_file() {
  mkdir -p $1
  if [ -f ${1}/${2} ]; then
    echo "File ${1}/${2} already exists. Skipping generation."
  fi
  if [ -z "${5}" ]; then
    u="_"
  else
    u=""
  fi
  echo "${3}=$(</dev/urandom tr -dc ${u}A-Z-a-z-0-9 | head -c${4:-32})" > ${1}/${2}
}

generate_salt_file() {
    generate_password_file $1 $2 $3 ${4:-16} "NoUnderscore"
}



CURRENT_DIR=$(cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
MYCROFT_CREDENTIALS_DIR=${CURRENT_DIR}/generated

generate_password_file ${MYCROFT_CREDENTIALS_DIR} postgres_password POSTGRES_PASSWORD
generate_password_file ${MYCROFT_CREDENTIALS_DIR} selene_postgres_password DB_PASSWORD
generate_password_file ${MYCROFT_CREDENTIALS_DIR} jwt_access_secret JWT_ACCESS_SECRET
generate_password_file ${MYCROFT_CREDENTIALS_DIR} jwt_refresh_secret JWT_REFRESH_SECRET
generate_password_file ${MYCROFT_CREDENTIALS_DIR} jwt_reset_secret JWT_RESET_SECRET
#for sha512 the salt is 16 charatcer long.
saltsize=16
echo "Current salt length is ${saltsize}. If this is incorrect, registrations will not work. (Default: 16, for sha512)"
generate_salt_file ${MYCROFT_CREDENTIALS_DIR} encyption_salt SALT $saltsize
