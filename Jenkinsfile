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
        stage ("Unit Testing") {
            steps {
                parallel (
                    "UITest" : {
                        echo "UI Test is running..."
                    },
                    "BackendTest" : {
                        echo "Backend Test is running..."
                        //sh "run-tests.sh"
                    }
                )
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
                script{
                def doesJavaRock = input(message: 'Deploy Image to Production?', ok: 'Yes', 
                        parameters: [booleanParam(defaultValue: true, 
                        description: 'Do you to deploy Docker image to Production Server',name: 'Deploy?')])
                }

                /*withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u riky126 -p ${dockerHubPwd}"
                    sh "docker push riky/cicd-demo:${DOCKER_TAG}"
                }*/
            }
        }

        stage('Deploy To GKE'){
            steps{
                
                script{
                    try{
                        //sh "kubectl set image deployment/kubecluster kubecluster=riky126/cicd-demo:${DOCKER_TAG}"

                        sh "chmod +x dome-chart/change-docker-tag.sh"
                        sh "./dome-chart/change-docker-tag.sh ${DOCKER_TAG}"
            
                    }catch(error){
                        sh "gcloud container clusters get-credentials kubecluster"
                    }
                }
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
