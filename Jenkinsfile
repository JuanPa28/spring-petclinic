pipeline {
    agent any

    environment {
        // Credenciales para DockerHub y GitHub
        DOCKERHUB_CREDENTIALS = credentials('DOCKERHUB_CREDENTIALS') // Crea tus credenciales de DockerHub en Jenkins
        GITHUB_CREDENTIALS = credentials('GitHub-PAT') // Credenciales de GitHub Personal Access Token
        IMAGE_NAME = "juanparamirez/imagen-jenkins:latest" // Nombre de la imagen con el tag 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                // Realiza un checkout del repositorio GitHub usando las credenciales
                git credentialsId: 'GitHub-PAT', branch: 'main', url: 'https://github.com/JuanPa28/spring-petclinic.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construir la imagen de Docker usando el Dockerfile en el repositorio
                    docker.build(IMAGE_NAME)
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    // Iniciar sesión en DockerHub y subir la imagen
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        // Subir la imagen con el tag 'latest' a DockerHub
                        docker.image(IMAGE_NAME).push()
                    }
                }
            }
        }
    }

    post {
        success {
            // Mensaje si el pipeline se ejecuta correctamente
            echo 'La imagen fue construida y subida exitosamente a DockerHub.'
        }
        failure {
            // Mensaje si el pipeline falla
            echo 'Hubo un error en la construcción o subida de la imagen.'
        }
    }
}
