kubectl create ns cloud
kubectl create ns edge1
helm install torque-cloud confluentinc/cp-helm-charts -n cloud -f values-cloud.yaml
helm install torque-edge1 confluentinc/cp-helm-charts -n edge1 -f values-edge1.yaml
