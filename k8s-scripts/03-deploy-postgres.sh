#!/bin/bash
echo "Deploying PostgreSQL Deployment and Service..."
kubectl apply -n rails-app -f kubernetes-files/dbservice.yaml
kubectl apply -n rails-app -f kubernetes-files/dbdeploy.yaml

echo "Waiting for PostgreSQL deployment to be ready..."
kubectl rollout status deployment/postgres -n rails-app
