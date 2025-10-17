pipeline {
    agent any

    tools {
        maven 'M3'
    }

    environment {
        IMAGE_NAME = "purvakamerkarjj5499079/spring-app:latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/BuiltByPurva/Deployment.git'
            }
        }

        stage('Build with Maven') {
            steps {
                bat 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials-id',
                    usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat """
                    echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                    docker push ${IMAGE_NAME}
                    """
                }
            }
        }

        stage('Run Container (Optional)') {
            when {
                expression { false } // DISABLED to prevent port conflicts
            }
            steps {
                bat "docker run -d -p 9090:8000 ${IMAGE_NAME}"
            }
        }
    }

    post {
        always {
            echo '✅ Pipeline finished successfully!'
        }
    }
}
