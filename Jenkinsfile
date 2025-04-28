pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'maven:3.8.4-openjdk-17'
        DOCKER_CREDENTIALS = 'dockerhub-credentials'  // Asegúrate de que el ID de credenciales coincida
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build JAR') {
            steps {
                script {
                    docker.image(DOCKER_IMAGE).inside {
                        sh 'mvn clean package -DskipTests'
                    }
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t my-app .'
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    sh 'docker push my-app'
                }
            }
        }
    }
}
