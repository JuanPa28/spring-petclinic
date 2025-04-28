pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'juanpa28/spring-petclinic:latest'
    }

    stages {
        stage('Build JAR') {
            agent {
                docker { image 'maven:3.8.4-openjdk-17' }
            }
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    sh '''
                        echo "$PASS" | docker login -u "$USER" --password-stdin
                        docker push $DOCKER_IMAGE
                    '''
                }
            }
        }
    }
}
