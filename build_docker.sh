#!/usr/bin/env bash

docker build --tag=udacity-devops-capstone .

docker image ls

docker run -p 8080:80 udacity-devops-capstone
