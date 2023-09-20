#!/bin/bash
#
# Runs the docker container

ws_host_dir=$(realpath ${DIR}/../../)

IMAGE="blakerbuchanan/altro-image"
TAG=0.0.1
DETACHED=""

CONTAINER_CMD='/bin/bash'
docker run \
    --privileged \
    --name altro_cpp \
    --hostname "$(hostname)-altro_cpp" \
    --restart always \
    $DETACHED \
    -it \
    --network host \
    -v "${ws_host_dir}":/workspaces:rw \
    "${IMAGE}:${TAG}" "${CONTAINER_CMD}"