#!/usr/bin/env bash

set -x

[ -z "$POSTGRES_USER" ] && POSTGRES_USER="postgres"
[ -z "$POSTGRES_PASSWORD" ] && POSTGRES_PASSWORD="postgres"

PG_PORT=5432

export POSTGRES_USER POSTGRES_PASSWORD PG_PORT

#
export SERVER_HOST=0.0.0.0
export SERVER_PORT=${PG_PORT}
#
env

#
docker-entrypoint.sh $@ &

tunnel server -v --proxy http://example.com --port $PORT

echo "Done"
