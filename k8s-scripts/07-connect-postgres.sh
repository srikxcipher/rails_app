#!/bin/bash
echo "Connecting to PostgreSQL inside the pod..."
pod=$(kubectl get pod -n rails-app -l app=postgres -o jsonpath="{.items[0].metadata.name}")
kubectl exec -it -n rails-app "$pod" -- psql -U srikant -d rails_dev

## Replace the details with <your-user-name> and <database>