pipeline {
environment {
REGISTRY = "ramakrishna41/django_test"
VERSION = "${env.BUILD_ID}-${env.GIT_COMMIT}"
registryCredential = 'dockerhub'
dockerImage = ''
}
agent any
stages {
stage('Cloning our Git') {
steps {
git 'https://github.com/RamaKrishna41/Django_Test.git'
}
}
stage('Building our image') {
steps{
script {
echo $BUILD_NUMBER
sh "sudo docker build -t django_test ."
sh "sudo docker tag django_test:latest ${RESISTRY}:${VERSION}"
sh "sudo docker push ${RESISTRY}:${VERSION}"
}
}
}
}
}