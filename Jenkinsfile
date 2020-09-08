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
                  withCredentials([usernamePassword( credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')])
                  {
                      sh "sudo docker login -u ${USERNAME} -p ${PASSWORD}"
                      sh 'sudo docker build --tag=udacity-devops-capstone .'
                  }
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