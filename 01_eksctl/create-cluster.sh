#!/bin/bash

# Variables
CLUSTER_NAME=eks-mundos-e
AWS_REGION=us-east-1

# Set AWS credentials 
aws sts get-caller-identity >> /dev/null
if [ $? -eq 0 ]
then
  echo "Credenciales testeadas, proceder con la creacion de cluster."

  # Creacion de cluster
  eksctl create cluster \
  --name $CLUSTER_NAME \
  --region $AWS_REGION \
  --nodes 3 \
  --node-type t2.micro \
  --with-oidc \
  --ssh-access \
  --ssh-public-key final-mundosE \
  --managed \
  --full-ecr-access \
  --zones us-east-1a,us-east-1b,us-east-1c

  if [ $? -eq 0 ]
  then
    echo "Cluster Setup Completo con eksctl ."
  else
    echo "Cluster Setup Falló mientras se ejecuto eksctl."
  fi
else
  echo "Por favor, ejecute aws configure y establezca las credenciales correctas."
  echo "Error en la configuración del cluster"
fi
