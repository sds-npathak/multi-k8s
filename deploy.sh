docker build -t npathak/multi-client:latest -t npathak/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t npathak/multi-server:latest -t npathak/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t npathak/multi-worker:latest -t npathak/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push npathak/multi-client:latest
docker push npathak/multi-server:latest
docker push npathak/multi-worker:latest
docker push npathak/multi-client:$SHA
docker push npathak/multi-server:$SHA
docker push npathak/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=npathak/multi-server:$SHA
kubectl set image deployments/client-deployment client=npathak/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=npathak/multi-worker:$SHA