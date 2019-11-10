#[step1]
#   -build the docker image and container
docker build . -t cicd-demo:v1

#[step2]
#   -push image to docker container registry
docker tag cicd-demo:v1 gcr.io/kubernetes-demo-80227/cicd-demo:v1
gcloud docker -- push gcr.io/kubernetes-demo-80227/cicd-demo:v1

#[step3]
#   -Create Kubernetes Cluters on Google Cloud Console
gcloud container clusters create kubecluster

#[step4]
#   -Run image on created cluster as application
kubectl run kubecluster --image=kubernetes-demo-80227/cicd-demo:v1 --port=8000 

#[step5]
#   -Expose Cluster deployment to pulic
kubectl expose deployment kubecluster --type="LoadBalancer"

#[step6]
#   -Get LoadBalance Public IP
kubectl get services kubecluster