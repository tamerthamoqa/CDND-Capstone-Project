# CDND-Capstone-Project

This is a repository for the fifth and final project in the AWS Cloud DevOps Engineer Udacity Nanodegree (Capstone Project). The project would deploy a Deep Learning API Microservice to classify input images according to the ImageNet dataset classes.

The objective of the project is as follows:
* Build a web application that serves a pre-trained PyTorch MobileNet-V2 ImageNet Classifier Deep Learning model via a Python Flask application in a Waitress production WSGI server.
* Set up a Docker image that contains the web application and required dependencies which can also load the model to an NVIDIA CUDA GPU if available for faster inference.
* Deploy the Docker image on a Kubernetes cluster using the AWS Elastic Kubernetes Service with the `eksctl` command line toolkit while leveraging a Jenkins CI/CD Pipeline.
* The Kubernetes cluster would contain two pods with one container each of the Docker image deployed on AWS EC2 `t3.large` instance nodes with the following Cluster AutoScaler setting: (minimum: one node, desired: two nodes, maximum: two nodes).
* The Kubernetes cluster would be updated via a Rolling Update strategy.


## Requirements
* [Docker](https://docs.docker.com/get-docker/)
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* [aws-cli](https://aws.amazon.com/cli/)
* [eksctl](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html)

__Note__: Links to useful resources I have found while doing the project are in the 'useful_resources.txt' file in 'project_instructions'.

## Project Files
* __server.py__: The web application server.
* __model__: Pre-trained ImageNet MobileNet-V2 PyTorch model.
* __templates__: Contains the required HTML file.
* __requirements.txt__: Required Python packages to run the application.
* __hadolint:__ Hadolint v1.18.0 Linux-86_64 executable.
* __Jenkinsfile__: Defines the Jenkins CI/CD stage pipeline to run on a Jenkins server.
* __Dockerfile__: Defines the Docker image.
* __docker_build.sh__: Builds the Docker image.
* __docker_upload.sh:__ Tags and uploads the Docker image to DockerHub.
* __docker_run_cpu.sh__: Runs the application locally in a Docker container using the CPU.
* __docker_run_gpu.sh__: Runs the application locally in a Docker container using an available NVIDIA CUDA GPU.
* __kubernetes_run_local.sh__: Runs the Docker image on a local Kubernetes cluster (e.g: Minikube).
* __kubernetes_deployment.yml__: Defines the Kubernetes deployment configuration on the AWS EKS Cluster.
* __eksctl_create_aws_kubernetes_cluster.yml__: Creates a Managed AWS EKS Cluster (implicitly using AWS Cloudformation).
* __eksctl_apply_deployment_aws_kubernetes_cluster.yml__: Applies the kubernetes_deployment.yml Kubernetes deployment configuration to the created EKS Cluster.
* __eksctl_delete_aws_kubernetes_cluster.yml__: Deletes the EKS Cluster and all its resources.
