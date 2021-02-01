#!/bin/bash -e

# disable update check
ibmcloud config --check-version=false

# IBMCLOUD_API_KEY is set in environment variable
echo
echo "# Logging ibmcloud."
echo
ibmcloud login -r us-south
if [ $? -ne 0 ]; then
    rc=$?
    echo "# Failed to login ibmcloud."
    exit $rc
fi

echo
echo "# Getting config of the cluster"
echo
ibmcloud ks cluster config -c mycluster-free
if [ $? -ne 0 ]; then
    rc=$?
    echo "# Failed to get config of cluster 'mycluster-free'."
    exit $rc
fi

echo
echo "# Sleeping 10 seconds to wait for RBAC synchronizes."
echo
sleep 10

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