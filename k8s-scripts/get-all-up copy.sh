#!/bin/bash

#../k8s-scripts/01-start-minikube.sh
../k8s-scripts/02-create-namespace.sh
../k8s-scripts/03-deploy-postgres.sh
../k8s-scripts/04-deploy-rails-app.sh
../k8s-scripts/05-enable-and-deploy-ingress.sh
../k8s-scripts/06-status-check.sh
../k8s-scripts/07-connect-postgres.sh


## Ensure you're turning up in correct order. 

## We will use this script to enable all the executables at once