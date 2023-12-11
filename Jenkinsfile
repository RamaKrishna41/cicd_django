pipeline {
agent any
environment {
REGISTRY = "ramakrishna41/django_test"
VERSION = "${env.BUILD_ID}"
registryCredential = 'dockerhub'
dockerImage = ''
}
stages {
stage('Building our image') {
steps{
echo "${BUILD_NUMBER}"
echo "${VERSION}"
sh "docker rmi -f django_test:latest"
sh "docker build -t django_test ."
sh "docker images"
sh 'docker tag django_test:latest ${REGISTRY}:${VERSION}'
    withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
    sh 'sudo docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD docker.io'
    sh 'sudo docker push ${REGISTRY}:${VERSION}'
    }
echo "Build Successfull"
}
}
stage('Deploy') {
    steps {
        sh 'docker pull ${RESISTRY}:${VERSION}'
        sh 'docker run -d -p 8000:8000 ${RESISTRY}:${VERSION}'
    }
}
}
}