pipeline {
    agent any
    environment{
        DOCKER_TAG = getDockerTag()

        //dockerHome = '/Applications/Docker.app/Contents/Resources/bin/'

        //def dockerHome = tool 'docker'
        //def mavenHome  = tool 'MyMaven ${mavenHome}/bin:'
        //env.PATH = "${dockerHome}/bin:${env.PATH}"
    }
    stages {
        stage('Build Docker Image'){
            steps{
                sh "docker build . -t riky126/cicd-demo:${DOCKER_TAG}"
            }
        }
        stage('DockerHub Push'){
            steps{

                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'docker-hub',
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {

                    sh 'echo uname=$USERNAME pwd=$PASSWORD'
                    sh "docker login -u ${USERNAME} -p ${PASSWORD}"
                    sh "docker push riky126/cicd-demo:${DOCKER_TAG}"
                    //sh "docker push riky/cicd-demo:${DOCKER_TAG}"
                
                }

                /*withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u riky126 -p ${dockerHubPwd}"
                    sh "docker push riky/cicd-demo:${DOCKER_TAG}"
                }*/
            }
        }

        stage('Deploy to GKE'){
            steps{
                sh "gcloud container clusters get-credentials kubecluster"
                sh "kubectl set image deployment/kubecluster kubecluster=riky126/cicd-demo:${PASSWORD}"
                //sh 'kubectl set image kubecluster kubecluster=riky126/cicd-demo:${DOCKER_TAG}'
            }
        }
       
        /*
        stage('Deploy to GKE'){
            steps{
                sh "chmod +x changeTag.sh"
                sh "./changeTag.sh ${DOCKER_TAG}"
                sshagent(['kops-machine']) {
                    sh "scp -o StrictHostKeyChecking=no services.yml node-app-pod.yml ec2-user@52.66.70.61:/home/ec2-user/"
                    script{
                        try{
                            sh "ssh ec2-user@52.66.70.61 kubectl apply -f ."
                        }catch(error){
                            sh "ssh ec2-user@52.66.70.61 kubectl create -f ."
                        }
                    }
                }
            }
        }*/
    }
}

def getDockerTag(){
    def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}
