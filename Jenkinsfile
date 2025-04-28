pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') // Crea tus credenciales en Jenkins con ID 'dockerhub-credentials'
        IMAGE_NAME = "juanparamirez/imagen-jenkins:latest" // Añadir un tag (latest)
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/JuanPa28/spring-petclinic.git' // Asegúrate de que este es tu repositorio
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
