#!/bin/bash

LOCUST="locust"
TARGET_HOST=${TARGET_HOST:-localhost}
LOCUST_MODE=${LOCUST_MODE:-standalone}

LOCUS_OPTS="-f /mnt/locust/locustfile.py --host=$TARGET_HOST"

if [[ "$LOCUST_MODE" = "master" ]]; then
    LOCUS_OPTS="$LOCUS_OPTS --master"
elif [[ "$LOCUST_MODE" = "worker" ]]; then
    LOCUS_OPTS="$LOCUS_OPTS --worker --master-host=$LOCUST_MASTER"
fi

echo "$LOCUST $LOCUS_OPTS"

exec $LOCUST $LOCUS_OPTS
