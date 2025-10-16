pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
        IMAGE_NAME = "purvakamerkarjj5499079/spring-app:latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/BuiltByPurva/Deployment.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    bat 'docker build -t spring-app:latest .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    bat "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                    bat "docker push spring-app:latest"
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    bat "docker run -d -p 3000:3000 --name microservice spring-app:latest"
                }
            }
        }
    }

    post {
        always {
            bat 'Pipeline finished!'
        }
    }
}
