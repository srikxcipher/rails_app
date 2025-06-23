#!/bin/bash


kubectl apply -f docker-credentials.yaml

kubectl apply -f git-clone-task.yaml

kubectl apply -f kaniko-task.yaml

kubectl apply -f pipeline.yaml 

kubectl apply -f service-account.yaml

kubectl create -f pipelinerun.yaml