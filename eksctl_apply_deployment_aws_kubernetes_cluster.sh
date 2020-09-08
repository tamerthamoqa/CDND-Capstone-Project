#!/usr/bin/env bash

aws eks --region us-east-1 update-kubeconfig --name udacity-devops-capstone-cluster
kubectl apply -f kubernetes/kubernetes_deployment.yml
kubectl get nodes
kubectl get pods
kubectl get svc
