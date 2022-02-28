



kubectl create ns cloud

kubectl create ns edge1


helm install torque-cloud confluentinc/cp-helm-charts -n cloud -f values-cloud.yaml

helm install torque-edge1 confluentinc/cp-helm-charts -n edge1 -f values-edge1.yaml

kubectl exec -n cloud -c cp-kafka-broker -it torque-cloud-cp-kafka-0 -- /bin/bash /usr/bin/kafka-console-producer --broker-list localhost:9092 --topic unit.1

kubectl exec -n cloud -c cp-kafka-broker -it torque-cloud-cp-kafka-0 -- /bin/bash /usr/bin/kafka-console-producer --broker-list localhost:9092 --topic unit.2

kubectl exec -n edge1 -c cp-kafka-broker -it torque-edge1-cp-kafka-0 -- /bin/bash  /usr/bin/kafka-console-consumer --bootstrap-server localhost:9092 --topic events --from-beginning

helm delete torque-cloud
helm delete torque-edge1

curl -X POST -d @example-replicator.json  http://localhost:8083/connectors --header "content-Type:application/json":svc
