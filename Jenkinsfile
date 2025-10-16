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
                    sh 'docker build -t spring-app:latest .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    sh "echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin"
                    sh "docker push spring-app:latest"
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    sh "docker run -d -p 3000:3000 --name microservice spring-app:latest"
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished!'
        }
    }
}
