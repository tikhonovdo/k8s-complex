docker build -t dtikhonov/multi-client:latest -t dtikhonov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dtikhonov/multi-server:latest -t dtikhonov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dtikhonov/multi-worker:latest -t dtikhonov/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dtikhonov/multi-client:latest
docker push dtikhonov/multi-server:latest
docker push dtikhonov/multi-worker:latest
docker push dtikhonov/multi-client:$SHA
docker push dtikhonov/multi-server:$SHA
docker push dtikhonov/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=dtikhonov/multi-client:$SHA
kubectl set image deployments/server-deployment server=dtikhonov/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=dtikhonov/multi-worker:$SHA