#!/bin/bash
echo " Deleting all Kubernetes resources and namespace 'rails-app'..."

kubectl delete -n rails-app -f kubernetes-files/ingress.yaml
kubectl delete -n rails-app -f kubernetes-files/webdeploy.yaml
kubectl delete -n rails-app -f kubernetes-files/webservice.yaml
kubectl delete -n rails-app -f kubernetes-files/dbdeploy.yaml
kubectl delete -n rails-app -f kubernetes-files/dbservice.yaml
kubectl delete namespace rails-app
minikube stop
minikube delete
