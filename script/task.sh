#!/bin/sh
set -eu

box=$1
tag=${2:-"latest"}
stack_name=$box

eval $(docker-machine env box-garden-master01)

cat << EOS > docker-compose.yml
version: '3'
services:
  task:
    image: $(docker-machine ip box-garden-registry):5000/${box}:${tag}
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
    logging:
      driver: fluentd
      options:
        fluentd-address: $(docker-machine ip box-garden-fluentd):24224
        tag: docker.{{.FullID}}
EOS

docker stack deploy --compose-file docker-compose.yml $stack_name && rm -rf docker-compose.yml
