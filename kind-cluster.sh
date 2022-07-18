#!/bin/bash
if ! which kind;
  then
     echo	-e "\033[31mERROR:\033[0m kind not found\nPlease install kind - https://kind.sigs.k8s.io/ and try again...!!!"
     exit 1
  else
     echo -e "\033[32mCreating Cluster with 3 nodes..."
     kind create cluster --config cluster.yaml
     sleep 10
     echo -e "\033[32mDeploying Nginx Ingress...\n"
     kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml 
     kubectl wait --namespace ingress-nginx \
       --for=condition=ready pod \
       --selector=app.kubernetes.io/component=controller \
       --timeout=300s
    echo -e "\033[32mDeploying Metric Server...\033[0m\n"
    kubectl apply -f components.yaml
    kubectl wait --namespace kube-system \
       --for=condition=Ready pods \
       --selector=k8s-app=metrics-server \
       --timeout=300s
    echo -e "\033[32mLabelling nodes...\033[0m\n"
    kubectl label nodes kustomize-demo-worker env=dev --overwrite
    kubectl label nodes kustomize-demo-worker2 env=stage --overwrite
    kubectl label nodes kustomize-demo-worker3 env=prod --overwrite
    echo -e "\033[32mCluster Deployed...\033[0m"
fi
