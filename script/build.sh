#!/bin/sh
set -eu

box=$1
tag=${2:-"latest"}
box_dir=$(cd $(dirname $0);pwd)/../boxs/$box

if [ ! -e $box_dir ]; then
  echo 'not found box';
  exit
fi

cd $box_dir
docker-machine env box-garden-build
eval $(docker-machine env box-garden-build)

docker build -t $(docker-machine ip box-garden-registry):5000/$box:${tag} .
docker push $(docker-machine ip box-garden-registry):5000/$box:${tag}
