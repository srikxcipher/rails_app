#!/bin/bash

kubectl delete -f docker-credentials.yaml

kubectl delete -f git-clone-task.yaml

kubectl delete -f kaniko-task.yaml

kubectl delete -f pipeline.yaml 

kubectl delete -f service-account.yaml

kubectl delete pipelinerun --all