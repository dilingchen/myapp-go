#!/bin/bash -e

echo
echo "Installing the ibmcloud cli and the container-service/kubernetes-service plugin."
echo
curl -sL https://raw.githubusercontent.com/IBM-Cloud/ibm-cloud-developer-tools/master/linux-installer/idt-installer | bash
if [ $? -ne 0 ]; then
    rc=$?
    echo "Failed to install the ibmcloud cli and the container-service/kubernetes-service plugin."
    exit $rc
fi

echo
echo "Successfully installed the ibmcloud cli and the container-service/kubernetes-service plugin."
echo
echo "Checking if awscli can work."
echo
ibmcloud dev help
if [ $? -ne 0 ]; then
    rc=$?
    echo "The ibmcloud cli can not work correctly."
    exit $rc
fi