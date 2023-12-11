pipeline {
agent any
environment {
REGISTRY = "ramakrishna41/django_test"
VERSION = "${env.BUILD_ID}"
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
    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD docker.io'
    sh 'docker push ${REGISTRY}:${VERSION}'
    }
echo "Build Successfull"
}
}
stage('Deploy') {
    steps {
        
        sh 'docker pull ${REGISTRY}:${VERSION}'
        sh 'docker run -d -p 8000:8000 --name django-container ${REGISTRY}:${VERSION}'
    }

}
}
}