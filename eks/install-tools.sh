#!/bin/bash -e

echo
echo "Installing the awscli v2."
echo
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo
echo "Successfully installed the awscli v2."
echo

export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"
export AWS_DEFAULT_REGION="us-west-2"
export AWS_DEFAULT_OUTPUT="json"

echo
echo "Checking if awscli can work."
echo
aws eks list-clusters

echo
echo "Installing kubectl."
echo
curl -LO https://dl.k8s.io/release/v1.18.15/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo
echo "Checking if kubectl can work."
echo
kubectl version --client

