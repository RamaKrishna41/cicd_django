pipeline {
environment {
REGISTRY = "ramakrishna41/django_test"
VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
registryCredential = 'dockerhub'
dockerImage = ''
}
agent any
stages {
stage('Building our image') {
steps{
echo "${BUILD_NUMBER}"
withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
    sh "sudo docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
sh "sudo docker build -t django_test ."
sh "sudo docker tag django_test:latest ${RESISTRY}:${VERSION}"
sh "sudo docker push ${RESISTRY}:${VERSION}"
echo "Build Successfull"
}
}
}
stage('Deploy') {
    steps {
        sh "sudo docker pull ${RESISTRY}:${VERSION}"
        sh "sudo docker run -d -p 8000:8000 ${RESISTRY}:${VERSION}"
    }
}
}
}