
peline {
    agent any

    environment {
        DOCKER_AUTH = credentials('DOCKER_CREDENTIALS')  // <-- Use your credentials ID here
    }

    stages {
        stage('Clone Repo') {
            steps {
                git 'https://github.com/YOUR_USERNAME/devops-pipeline-demo.git'
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
                    dockerImage = docker.build("raghugkr/webapp-image")  // Change repo if needed
                }
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker rm -f webapp || true
                docker run -d -p 80:80 --name webapp raghugkr/webapp-image
                '''
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    dockerImage.push('latest')
                }
            }
        }
    }
}
