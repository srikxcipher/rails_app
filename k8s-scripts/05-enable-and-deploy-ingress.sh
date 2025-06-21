#!/bin/bash
echo "Enabling Minikube ingress addon..."
minikube addons enable ingress

echo "Waiting for ingress controller pod to be ready..."
kubectl wait --namespace ingress-nginx \
  --for=condition=Ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s

echo "Applying ingress resource for the Rails app..."
kubectl apply -n rails-app -f kubernetes-files/ingress.yaml

echo "Ingress deployed. Add the following to /etc/hosts:"
minikube_ip=$(minikube ip)
echo "$minikube_ip"
