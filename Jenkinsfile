pipeline {
    agent any

    environment {
        DOCKER_AUTH = credentials('DOCKER_CREDENTIALS')
        GIT_AUTH = credentials('github-creds')
    }

    stages {

        stage('Clone GitHub Repo') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-creds',
                    url: 'https://github.com/Raghu-GKR/project-cicd.git'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                sh '''
                    echo "$DOCKER_AUTH_PSW" | docker login -u "$DOCKER_AUTH_USR" --password-stdin
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("raghugkr/webapp-image:latest", ".")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.image("raghugkr/webapp-image:latest").push()
                }
            }
        }

        stage('Run Locally') {
            steps {
                sh '''
                    docker rm -f webapp || true
                    docker run -d -p 80:80 --name webapp raghugkr/webapp-image:latest
                '''
            }
        }

        stage('Deploy Web App') {
            steps {
                sh '''
                    docker rm -f webapp || true
                    docker pull raghugkr/webapp-image:latest
                    docker run -d -p 8081:80 --name webapp raghugkr/webapp-image:latest
                '''
            }
        }
    }
}
