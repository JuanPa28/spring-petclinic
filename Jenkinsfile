pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') // Crea tus credenciales en Jenkins
        IMAGE_NAME = "juanparamirez/imagen-jenkins"
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/JuanPa28/spring-petclinic.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(IMAGE_NAME)
                }
            }
        }
        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        docker.image(IMAGE_NAME).push()
                    }
                }
            }
        }
    }
}
