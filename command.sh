#[step1]
#   -build the docker image and container
docker build . -t cicd-demo:v1

#[step2]
#   -push image to docker container registry
docker tag cicd-demo:v1 gcr.io/kubernetes-demo-80227/cicd-demo:v1
gcloud docker -- push gcr.io/kubernetes-demo-80227/cicd-demo:v1
#push to docker hub
docker push [image-name]:tag
docker build . -t riky126/cicd-demo:v1
docker push riky126/cicd-demo:v1

#[step3]
#   -Create Kubernetes Cluters on Google Cloud Console
gcloud container clusters create kubecluster

#[step4]
#   -Run image on created cluster as application
kubectl run kubecluster --image=kubernetes-demo-80227/cicd-demo:v1 --port=8080 
kubectl run kubecluster --image=riky126/cicd-demo:v1 --port=8080 

kubectl run  --generator=run-pod/v1 kubecluster --image=kubernetes-demo-80227/cicd-demo:v1 --port=8080 

#[step5]
#   -Expose Cluster deployment to pulic
kubectl expose deployment kubecluster --type="LoadBalancer"

#[step6]
#   -Get LoadBalance Public IP
kubectl get services kubecluster

#delete cluster
gcloud container clusters delete kubecluster

#delete 

#Helm setup
#Tiller in kubernetes as a ServiceAccount
kubectl apply -f <filename.yaml>
#initialise helm
helm init --service-account helm
#verify helm
kubectl get deploy,svc tiller-deploy -n kube-system

# Helm delete
helm del --purge <clustername>

helm del <chartname>

helm install --name helm-demo ./demo-chart --set service.type=LoadBalancer

helm upgrade helm-cluster ./demo-chart

CODE:
kill all running containers with docker kill $(docker ps -q)
delete all stopped containers with docker rm $(docker ps -a -q)
delete all images with docker rmi $(docker images -q)

tar -xvzf [ file_name ].tar.gz

docker build -t gcr.io/[ id-project ]/echo-app:v1 .   (have  . end commandline)

docker run -d -p 8080:8000 gcr.io/[id-project]/echo-app:v1
docker push gcr.io/[id-project]/echo-app:v1

gcloud container clusters create echo-cluster \
                --num-nodes 2 \
                --machine-type n1-standard-2 \
                --zone us-central1-a

kubectl run  echo-web \
    --image=gcr.io/[id-project]/echo-app:v1 \
    --port=8000

kubectl expose deployment echo-web --type="LoadBalancer" --port=80 --target-port=8000