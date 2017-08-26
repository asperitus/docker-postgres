#!/usr/bin/env bash

set -x

[ -z "$POSTGRES_USER" ] && POSTGRES_USER="postgres"
[ -z "$POSTGRES_PASSWORD" ] && POSTGRES_PASSWORD="postgres"
[ -z "$PORT" ] && PORT=5432

export POSTGRES_USER POSTGRES_PASSWORD PORT

function define(){
    IFS='\n' read -r -d '' ${1} || true;
}

define POSTGRES_CONFIG <<EOF
{
    "allocated_storage": 2,
    "database": "postgres",
    "hostname": "${CF_INSTANCE_IP}",
    "password": "${POSTGRES_PASSWORD}",
    "port": ${CF_INSTANCE_PORT},
    "uri": "postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${CF_INSTANCE_IP}:${CF_INSTANCE_PORT}/postgres",
    "username": "${POSTGRES_USER}",
    "uuid": "${CF_INSTANCE_GUI}"
}
EOF

export POSTGRES_CONFIG

#
env

#
docker-entrypoint.sh -p $PORT

echo "Done"