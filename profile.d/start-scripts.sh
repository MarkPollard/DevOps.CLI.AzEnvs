#! /bin/bash

title

cli-help

if [ -n "$INIT_CLUSTER" ]; then
  az-initlogin

  az aks get-credentials --resource-group $INIT_CLUSTER_RG --name $INIT_CLUSTER --overwrite-existing

  kubelogin convert-kubeconfig -l azurecli

  kubectl config set-context --current --namespace="$INIT_CLUSTER_NS"
fi