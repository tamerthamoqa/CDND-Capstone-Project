#!/usr/bin/env bash

aws eks --region us-east-1 update-kubeconfig --name udacity-devops-capstone-gpu-cluster
kubectl create -f https://raw.githubusercontent.com/NVIDIA/k8s-device-plugin/1.0.0-beta4/nvidia-device-plugin.yml
kubectl apply -f kubernetes/kubernetes_deployment.yml
kubectl get nodes
kubectl get pods
kubectl get svc
