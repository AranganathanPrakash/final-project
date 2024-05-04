pipeline {
    agent any
    
    environment {
        registry = "973625940209.dkr.ecr.us-east-1.amazonaws.com/arar123"
        EKS_CLUSTER_NAME = "clustername"
        KUBE_NAMESPACE = "default"
    }
    
    tools {
        maven 'Maven3'
    }
    
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean install -DskipTests'
            }
        }
        
        stage('Building image') {
            steps {
                script {
                    dockerImage = docker.build registry
                }
            }
        }
        
        stage('Pushing to ECR') {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS']]) {
                        sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${registry}"
                        sh 'docker push 973625940209.dkr.ecr.us-east-1.amazonaws.com/arar123'
                    }
                }
            }
        }
        
       stage('K8S Deploy') {
    steps {
        script {
            // Use AWS credentials to authenticate with the Kubernetes cluster
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS']]) {
                // Set up Kubernetes configuration to interact with the cluster
                withKubeConfig(credentialsId: 'newk8s', serverUrl: 'https://01CF7810F2C3A88FA2AA1F0238EFAED8.gr7.us-east-2.eks.amazonaws.com') {
                    // Apply Kubernetes configurations defined in deployment.yaml
                    sh 'kubectl apply -f deployment.yaml'
                        }
                    }
                }
            }
        }
    }
}
