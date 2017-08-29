#!/usr/bin/env bash

#args
# APP_NAME

usage() {
   cat << EOF

usage: $(basename $0) APP_NAME

EOF

exit 1
}

[[ $# -lt 1 ]] && usage

app_name=$1

#
which cf; if [ $? -ne 0 ]; then
    echo "cf not installed. see https://github.com/cloudfoundry/cli/releases"
    exit 1
fi

#
cf push $app_name --docker-image asperitus/postgres --health-check-type process -i 1 -m 512M -k 2G

