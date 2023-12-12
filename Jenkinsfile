pipeline {
    agent any
    environment {
        REGISTRY = "ramakrishna41/django_test"
        VERSION = "${env.BUILD_ID}"
    }
    stages {
        stage('Database Update') {
            steps {
                sh 'docker cp django-container:/usr/src/app/database/db.sqlite3 ./database'
            }
        }
        stage('Building image') {
            steps{
                sh "docker build -t django_test ."
                sh 'docker tag django_test:latest ${REGISTRY}:${VERSION}'
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD docker.io'
                    sh 'docker push ${REGISTRY}:${VERSION}'
                }
            }
        }
        stage('Removing the old container'){
            steps {
                sh 'docker rm -f django-container'
                sh "docker rmi -f django_test:latest"
                sh 'docker images'
                sh 'docker ps'
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker pull ${REGISTRY}:${VERSION}'
                sh 'docker run -d -p 8000:8000 --name django-container ${REGISTRY}:${VERSION}'
                sh 'docker ps'
            }
        }
        
    }
}