#!/bin/bash
echo "Creating Kubernetes namespace 'rails-app'..."
kubectl create namespace rails-app || echo "Namespace already exists."
