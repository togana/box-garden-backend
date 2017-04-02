#!/bin/sh
set -eu

docker-machine ls -q --filter name=box-garden | xargs docker-machine rm -y
