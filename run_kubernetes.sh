#!/usr/bin/env bash

dockerpath=tamerthamoqa/udacity-devops-capstone

kubectl run udacity-devops-capstone \
    --image=$dockerpath \
    --port=80 \
    --labels app=udacity-devops-capstone  # Kubernetes label must be DNS-compliant

kubectl get pods

kubectl port-forward udacity-devops-capstone 8080:80
