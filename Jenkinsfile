pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials-id')
        IMAGE_NAME = "spring-app:latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/BuiltByPurva/Deployment.git'
            }
        }

        stage('Build with Maven') {
                    withMaven(maven: 'M3') {
                        bat 'mvn clean package -DskipTests'
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
                            withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials-id',
                                usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                                bat """
                                echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                                docker tag spring-app:latest your-dockerhub-username/spring-app:latest
                                docker push your-dockerhub-username/spring-app:latest
                                """
                            }
                        }
                    }
                }

        stage('Deploy Container') {
             steps {
                   script {
                            bat "docker run -d -p 8080:8080 spring-app:latest"
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
