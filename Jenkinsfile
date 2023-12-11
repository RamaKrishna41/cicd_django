pipeline {
agent any
environment {
REGISTRY = "ramakrishna41/django_test"
VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
registryCredential = 'dockerhub'
dockerImage = ''
}
stages {
stage('Building our image') {
steps{
echo "${BUILD_NUMBER}"
echo "${VERSION}"
sh "docker build -t django_test ."
    withCredentials([string(credentialsId: 'DOCKER_PASSWORD', variable: 'DOCKER_PASSWORD')]) {
        sh 'docker login -u {ramakrishna41} -p ${DOCKER_PASSWORD}'
    }
sh "docker tag django_test:latest ${RESISTRY}:${VERSION}"
sh "docker push ${RESISTRY}:${VERSION}"
echo "Build Successfull"
}
}
stage('Deploy') {
    steps {
        sh "docker pull ${RESISTRY}:${VERSION}"
        sh "docker run -d -p 8000:8000 ${RESISTRY}:${VERSION}"
    }
}
}
}

stage('Build Docker Image'){
        sh 'docker build -t {dockerId}/{projectName}:${BUILD_NUMBER} .'
  }
  stage('Push Docker Image'){
        withCredentials([string(credentialsId: 'DOKCER_HUB_PASSWORD', variable: 'DOKCER_HUB_PASSWORD')]) {
          sh "docker login -u {dockerId} -p ${DOKCER_HUB_PASSWORD}"
        }
        sh 'docker push {dockerId}/{projectName}:${BUILD_NUMBER}'
  }
  stage("Deploy To Kuberates Cluster"){
        sh 'kubectl apply -f {yaml file name}.yaml'
        sh 'kubectl set image deployments/{deploymentName} {container name given in deployment yaml file}={dockerId}/{projectName}:${BUILD_NUMBER}'
  }