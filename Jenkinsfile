pipeline
{
    agent any

    stages
    {
        stage('Lint HTML')
        {
            steps
            {
                sh 'tidy -q -e templates/*.html'
            }
        }

        stage('Lint Python File')
        {
            steps
            {
                // Install python requirements
                sh 'pip3 install --upgrade pip && \
                pip3 install --upgrade setuptools && \
                pip3 install -r requirements.txt'
                // E1101 was causing the following weird pylint warning:
                //  Module 'torch' has no 'device' member (no-member), so decided to disable it
                sh 'pylint --disable=R,C,W1202,W1203,E1101 server.py'
            }
        }

        stage('Lint Dockerfile')
        {
            steps
            {
                sh './hadolint/hadolint-Linux-x86_64 Dockerfile'
            }
        }

        stage('Build Docker Image')
        {
              steps
              {
                  sh 'docker build --tag=udacity-devops-capstone .'
              }
        }

        stage('Push Docker Image')
        {
            steps
            {
                withDockerRegistry([url: "", credentialsId: "dockerhub"])
                {
                    sh 'sudo docker tag udacity-devops-capstone tamerthamoqa/udacity-devops-capstone'
                    sh 'sudo docker push tamerthamoqa/udacity-devops-capstone'
                }

            }
        }

        stage('Deploy to AWS Elastic Kubernetes Service Cluster')
        {
            steps 
            {
                withAWS(region:'us-east-1', credentials:'aws')
                {
                    sh 'aws eks --region us-east-1 update-kubeconfig --name udacity-devops-capstone-cluster'
                    sh 'kubectl apply -f kubernetes/kubernetes_deployment.yml'
                    sh 'kubectl get nodes'
                    sh 'kubectl get pods'
                    sh 'kubectl get svc'
                }
            }
        }

        stage("Clean up Docker")
        {
            steps
            {
                sh "sudo docker system prune -f"
            }
        }
    }
}