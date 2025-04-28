pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'juanpa28/spring-petclinic:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                // Asegúrate de clonar el repositorio antes de continuar
                git 'https://github.com/JuanPa28/spring-petclinic.git'
            }
        }

        stage('Build JAR') {
            agent {
                docker { image 'maven:3.8.4-openjdk-17' }
            }
            steps {
                // Ejecutar el comando Maven para construir el archivo JAR
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                // Construir la imagen Docker usando el Dockerfile
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Push to DockerHub') {
            steps {
                // Usar las credenciales almacenadas en Jenkins para hacer login en DockerHub
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                        echo "$PASS" | docker login -u "$USER" --password-stdin
                        docker push $DOCKER_IMAGE
                    '''
                }
            }
        }
    }

    post {
        always {
            // Realizar limpieza después de la ejecución
            cleanWs()
        }
    }
}
