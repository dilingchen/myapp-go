#!/bin/bash -e

# AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY are set in environment variables
AWS_DEFAULT_REGION="us-west-2"
AWS_DEFAULT_OUTPUT="json"

echo
echo "# Getting config of the cluster"
echo
aws eks update-kubeconfig --name my-cluster
if [ $? -ne 0 ]; then
    rc=$?
    echo "# Failed to get config of cluster 'mycluster'."
    exit $rc
fi

echo
echo "# Checking if kubectl can work."
echo
kubectl get nodes
if [ $? -ne 0 ]; then
    rc=$?
    echo "# Failed to get nodes info."
    exit $rc
fi

echo
echo "# Deploying the app to the cluster."
echo
kubectl apply -f ./services/myapp-go/deployment.yaml
if [ $? -ne 0 ]; then
    rc=$?
    echo "# Failed to deploy the app to the cluster."
    exit $rc
fi
