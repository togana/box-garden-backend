#!/bin/sh
set -eu

box=$1
tag=${2:-"latest"}
stack_name=$(uuidgen)

eval $(docker-machine env box-garden-master01)

cat << EOS > docker-compose.yml
version: '3'
services:
  web:
    image: $(docker-machine ip box-garden-registry):5000/${box}:${tag}
    ports:
      - '80:80'
    deploy:
      replicas: 2
      update_config:  
        parallelism: 1
        delay: 10s
      restart_policy:
        condition: on-failure
EOS

docker stack deploy --compose-file docker-compose.yml $stack_name && rm -rf docker-compose.yml
