#!/usr/bin/env bash

. env.sh

HOSTS="$CROSS_ELASTIC_IP $GENERIC_ELASTIC_IP $STRAPP_ELASTIC_IP $JETTY_ELASTIC_IP"

for host in $HOSTS; do
  docker run -d --network local_elk_net \
    docker.stb.intra/storebrand/alpine-curl:0.1.1 \
    --header 'Content-Type: application/json' \
    -XPUT "http://${host}:9200/_all/_settings" \
    -d '{"index.blocks.read_only_allow_delete": null}'
done
