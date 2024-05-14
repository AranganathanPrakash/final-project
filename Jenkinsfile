pipeline {
    agent any
    
    environment {
        // Define environment variables
        registry = "973625940209.dkr.ecr.us-east-1.amazonaws.com/springpro8888"
        eksClusterName = "clustername"
        kubeNamespace = "default"
    }
    
    stages {
        stage('Build') {
            steps {
                // Build the project using Maven
                sh 'mvn clean install -DskipTests'
            }
        }
        
        stage('Building Image') {
            steps {
                script {
                    // Build Docker image
                    dockerImage = docker.build registry
                }
            }
        }
        
        stage('Pushing to ECR') {
            steps {
                script {
                    // Authenticate with ECR and push Docker image
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS']]) {
                        sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 973625940209.dkr.ecr.us-east-1.amazonaws.com"
                        sh "docker push ${registry}"
                    }
                }
            }
        }
        
        stage('K8S Deploy') {
            steps {
                script {
                    // Authenticate with Kubernetes cluster
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS']]) {
                        // Configure Kubernetes access
                        withKubeConfig(credentialsId: 'newk8s', serverUrl: 'https://53027EEE4265E52B92577F4B09B9E9CD.gr7.us-east-1.eks.amazonaws.com') {
                            // Deploy application to Kubernetes
                            sh 'kubectl apply -f deployment.yaml'
                        }
                    }
                }
            }
        }
    }
}
