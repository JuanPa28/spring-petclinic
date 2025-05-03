pipeline {
  agent none

  environment {
    DOCKERHUB_CREDENTIALS = credentials('DOCKERHUB_CREDENTIALS')
    GITHUB_CREDENTIALS = credentials('GitHub-PAT')
    IMAGE_NAME = "juanparamirez/imagen-jenkins:latest"
  }

  stages {
    stage('Checkout') {
      agent any
      steps {
        git credentialsId: 'GitHub-PAT', branch: 'main', url: 'https://github.com/JuanPa28/spring-petclinic.git'
      }
    }

    stage('Maven Install') {
      agent {
        docker {
          image 'maven:3.8.8'
        }
      }
      steps {
        sh 'mvn clean install'
      }
    }

    stage('Docker Build') {
      agent any
      steps {
        sh "docker build -t ${IMAGE_NAME} ."
      }
    }

    stage('Docker Push') {
      agent any
      steps {
        withCredentials([usernamePassword(credentialsId: 'DOCKERHUB_CREDENTIALS', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh "docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}"
          sh "docker push ${IMAGE_NAME}"
        }
      }
    }
  }

  post {
    success {
      echo 'La imagen fue construida y subida exitosamente a DockerHub.'
    }
    failure {
      echo 'Hubo un error en la construcción o subida de la imagen.'
    }
  }
}
