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
withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
}
sh "docker build -t django_test ."
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