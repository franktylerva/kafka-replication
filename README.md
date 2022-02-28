

Create namespaces for each cluster.
```
kubectl create ns cloud
kubectl create ns edge1
```

Install Confluent Kafka in each namespace.

```
helm install cloud confluentinc/cp-helm-charts -n cloud -f values-cloud.yaml

helm install edge1 confluentinc/cp-helm-charts -n edge1 -f values-edge1.yaml
```

Setup a console producer in the cloud for topic 1.
```
kubectl exec -n cloud -c cp-kafka-broker -it cloud-cp-kafka-0 -- /bin/bash /usr/bin/kafka-console-producer --broker-list localhost:9092 --topic topic.1
```

Setup a console producer in the cloud for topic 2.
```
kubectl exec -n cloud -c cp-kafka-broker -it cloud-cp-kafka-0 -- /bin/bash /usr/bin/kafka-console-producer --broker-list localhost:9092 --topic topic.2
```

Setup a consumer on the edge cluster
```
kubectl exec -n edge1 -c cp-kafka-broker -it edge1-cp-kafka-0 -- /bin/bash  /usr/bin/kafka-console-consumer --bootstrap-server localhost:9092 --topic events --from-beginning
```

Setup replication using Kafka Connect
```
curl -X POST -d @example-replicator.json  http://localhost:8083/connectors --header "content-Type:application/json":svc
```