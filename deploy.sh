docker build -t purporz/multi-client:latest -t purporz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t purporz/multi-server:latest -t purporz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t purporz/multi-worker:latest -t purporz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push purporz/multi-client:latest
docker push purporz/multi-server:latest
docker push purporz/multi-worker:latest

docker push purporz/multi-client:$SHA
docker push purporz/multi-server:$SHA
docker push purporz/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=purporz/multi-server:$SHA
kubectl set image deployments/client-deployment server=purporz/multi-client:$SHA
kubectl set image deployments/worker-deployment server=purporz/multi-worker:$SHA