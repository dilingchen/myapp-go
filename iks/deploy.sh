#!/bin/bash -e

# disable update check
ibmcloud config --check-version=false

export IBMCLOUD_API_KEY="${IBMCLOUD_API_KEY}"
echo
echo "# Logging ibmcloud."
echo
ibmcloud login -r us-south

echo
echo "# Getting config of the cluster"
echo
ibmcloud ks cluster config -c mycluster-free

echo
echo "# Sleeping 10 seconds to wait for RBAC synchronizes."
echo
sleep 10

echo
echo "# Checking if kubectl can work."
echo
kubectl get nodes

echo
echo "# Deploying the app to the cluster."
echo
kubectl apply -f ./services/myapp-go/deployment.yaml

echo
echo "# Checking the app on the cluster."
echo
kubectl get pods -l app=myapp-go
