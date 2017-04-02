#!/bin/sh
set -eu

# init docker registry
cd $(cd $(dirname $0);pwd)/../registry
docker-machine create -d virtualbox \
  box-garden-registry
eval $(docker-machine env box-garden-registry)
docker-compose up -d

# init build server
docker-machine create -d virtualbox \
  --engine-insecure-registry $(docker-machine ip box-garden-registry):5000 \
  box-garden-build

# init log server
cd ../fluent
docker-machine create -d virtualbox box-garden-fluentd
eval $(docker-machine env box-garden-fluentd)
docker-compose up -d

# init swarm master
docker-machine create -d virtualbox \
  --engine-insecure-registry $(docker-machine ip box-garden-registry):5000 \
  box-garden-master01
eval $(docker-machine env box-garden-master01)

docker swarm init --advertise-addr $(docker-machine ip box-garden-master01)
WORKER_TOKEN=$(docker swarm join-token worker | grep -v command | tr -d "\n\\")

# init swarm worker
docker-machine create -d virtualbox \
  --engine-insecure-registry $(docker-machine ip box-garden-registry):5000 \
  box-garden-worker01
eval $(docker-machine env box-garden-worker01)
eval $WORKER_TOKEN
