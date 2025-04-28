pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'juanpa28/spring-petclinic:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                // Asegúrate de especificar la rama correcta
                git branch: 'main', url: 'https://github.com/JuanPa28/spring-petclinic.git'
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
                // Usar los secretos de GitHub como variables de entorno para login en DockerHub
                withCredentials([string(credentialsId: 'DOCKER_USERNAME', variable: 'DOCKER_USERNAME'), 
                                 string(credentialsId: 'DOCKER_PASSWORD', variable: 'DOCKER_PASSWORD')]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
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
