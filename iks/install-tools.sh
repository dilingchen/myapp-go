#!/bin/bash -e

echo
echo "Installing the ibmcloud cli and the container-service/kubernetes-service plugin."
echo
curl -sL https://raw.githubusercontent.com/IBM-Cloud/ibm-cloud-developer-tools/master/linux-installer/idt-installer | bash

echo
echo "Checking if awscli can work."
echo
ibmcloud dev help

echo
echo "Installing kubectl."
echo
curl -LO https://dl.k8s.io/release/v1.18.15/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo
echo "Checking if kubectl can work."
echo
kubectl version --client

