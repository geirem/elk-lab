#!/usr/bin/env bash

declare -x ELK_BASE_DIR=/var/lib/elasticsearch
declare -x ELK_DATA_DIR=/var/lib/elasticsearch/data;
declare -x ELK_KEY_DIR=/etc/elk/keys;
declare -x ELK_CONFIG_DIR=/etc/elk/config;

declare -x JETTY_ELASTIC_IP=192.168.0.13

declare -x ROUTER_LOGSTASH_IP=192.168.0.100
declare -x CROSS_KIBANA_IP=192.168.0.200
