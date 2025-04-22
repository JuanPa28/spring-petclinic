pipeline {
    agent any
    stages {
        stage('Build Maven Project') {
            agent {
                docker { image 'maven:3.8.4-openjdk-17' }
            }
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t spring-petclinic:latest .'
            }
        }
    }
}
