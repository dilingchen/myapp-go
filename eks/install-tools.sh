#!/bin/bash -e

echo
echo "Installing prerequisite: unzip"
echo
sudo apt install unzip

echo
echo "Installing the awscli v2."
echo
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
if [ $? -ne 0 ]; then
    rc=$?
    echo "Failed to install the awscli v2."
    exit $rc
fi

echo "Successfully installed the awscli v2."

# AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY are set in environment variables
AWS_DEFAULT_REGION="us-west-2"
AWS_DEFAULT_OUTPUT="json"

echo "Checking if awscli can work."
aws eks list-clusters
if [ $? -ne 0 ]; then
    rc=$?
    echo "The awscli can not work correctly."
    exit $rc
fi
