#!/bin/bash
echo "Checking status of all resources in 'rails-app' namespace..."

kubectl get all -n rails-app

echo "Ingress info:"
kubectl get ingress -n rails-app

echo "Rails logs:"
kubectl logs -n rails-app deployment/webapp-deploy
