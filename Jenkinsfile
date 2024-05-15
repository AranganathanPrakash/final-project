pipeline {
    agent any
    
    environment {
        // Define environment variables
        registry = "973625940209.dkr.ecr.us-east-2.amazonaws.com/arar123kk"
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
     steps{  
         script {
                sh 'aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 973625940209.dkr.ecr.us-east-2.amazonaws.com'
                sh 'docker push arar123kk:latest 973625940209.dkr.ecr.us-east-2.amazonaws.com/arar123kk:latest'
                    }
                }
            }
        
       stage('K8S Deploy') {
            steps {
                script {
                        withKubeConfig(credentialsId: 'newk8s', serverUrl: 'https://53027EEE4265E52B92577F4B09B9E9CD.gr7.us-east-1.eks.amazonaws.com') {
                            
                            sh 'kubectl apply -f deployment.yaml'
                        }
                }
            }
        }
    }
}
