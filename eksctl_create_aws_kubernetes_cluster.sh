#!/usr/bin/env bash
# $1: Name of EC2 Key Pair currently stored in AWS

eksctl create cluster \
--name udacity-devops-capstone-cluster \
--version 1.17 \
--region us-east-1 \
--nodegroup-name udacity-devops-capstone-nodes \
--node-type t3.large \
--nodes 2 \
--nodes-min 1 \
--nodes-max 2 \
--ssh-access \
--ssh-public-key=$1 \
--managed