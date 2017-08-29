#!/usr/bin/env bash

set -x
#args
# APP_NAME

usage() {
   cat << EOF

usage: $(basename $0) APP_NAME [LOCAL_PORT]

EOF

exit 1
}

[[ $# -lt 1 ]] && usage

app_name=$1

[ -z "$2" ] && local_port="5432" || local_port="$2"

#
which cf; if [ $? -ne 0 ]; then
    echo "cf not installed. see https://github.com/cloudfoundry/cli/releases"
    exit 1
fi

which jq; if [ $? -ne 0 ]; then
    echo "jq required. see https://stedolan.github.io/jq/"
    exit 1
fi

which tunnel; if [ $? -ne 0 ]; then
    echo "tunnel not installed. see https://github.com/asperitus/tunnel"
    exit 1
fi

#
guid=$(cf curl /v2/apps?q=name:$app_name | jq -r '.resources|.[].metadata.guid')
uri=https://$(cf curl /v2/apps/$guid/stats | jq -r '."0".stats.uris[0]')

#
[ -z "$http_proxy" ] && proxy_option="" || proxy_option="--proxy $http_proxy"

tunnel client -v $proxy_option --keepalive 12s $uri $local_port:localhost:5432

#