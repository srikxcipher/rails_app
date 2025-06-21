#!/bin/bash
echo "Deploying Rails application Deployment and Service..."
kubectl apply -n rails-app -f kubernetes-files/webservice.yaml
kubectl apply -n rails-app -f kubernetes-files/webdeploy.yaml

echo "Waiting for Rails deployment to be ready..."
kubectl rollout status deployment/webapp-deploy -n rails-app
