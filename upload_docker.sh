#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `build_docker.sh`

dockerpath=tamerthamoqa/udacity-devops-capstone

echo "Docker ID and Image: $dockerpath"
docker login --username=tamerthamoqa
docker tag udacity-devops-capstone tamerthamoqa/udacity-devops-capstone

docker push tamerthamoqa/udacity-devops-capstone
