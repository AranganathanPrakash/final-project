pipeline {
    agent any
    
    environment {
        // Define environment variables
        registry = "973625940209.dkr.ecr.us-east-1.amazonaws.com/arar123"
        eksClusterName = "clustername"
        kubeNamespace = "default"
    }
    
    tools {
        // Use Maven tool for building
        maven 'Maven3'
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
                        sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${registry}"
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
                        withKubeConfig(credentialsId: 'newk8s', serverUrl: 'https://01CF7810F2C3A88FA2AA1F0238EFAED8.gr7.us-east-2.eks.amazonaws.com') {
                            // Deploy application to Kubernetes
                            sh 'kubectl apply -f deployment.yaml'
                        }
                    }
                }
            }
        }
    }
}
