pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('DOCKERHUB_CREDENTIALS ') // Crea tus credenciales de DockerHub en Jenkins
        GITHUB_CREDENTIALS = credentials('GitHub-PAT') // Credenciales de GitHub Personal Access Token
        IMAGE_NAME = "juanparamirez/imagen-jenkins:latest" // Añadir un tag (latest)
    }
    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'GitHub-PAT', branch: 'main', url: 'https://github.com/JuanPa28/spring-petclinic.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Construir la imagen de Docker
                    docker.build(IMAGE_NAME) 
                }
            }
        }
        stage('Push to DockerHub') {
            steps {
                script {
                    // Hacer login en DockerHub y subir la imagen
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        docker.image(IMAGE_NAME).push() // Subir la imagen a DockerHub
                    }
                }
            }
        }
    }
}
