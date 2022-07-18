#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Pass required arguments !"
    echo "Usage: $0 NAMESPACE KUSTOMIZE_PATH"
    exit 1
else
   export NAMESPACE=$1
   export KUSTOMIZE_PATH=$2
   export DOMAIN=$(echo $(ipconfig getifaddr en0) | sed -e 's/\./\-/g')
fi

echo "Creating namespace"
envsubst < namespace.yaml | kubectl apply -f -
echo "Updating ingress domain"
sed -i '' "s/- host.*/- host: $DOMAIN.sslip.io/g" base/ingress.yaml

echo "Updating ingress per env"
for i in development staging production;
  do sed -i '' "s/.[0-9].*.sslip.io/\.$DOMAIN.sslip.io/g" overlays/$i/kustomization.yaml
done

echo "Deploying resources in the ${NAMESPACE}"
kustomize build ${KUSTOMIZE_PATH} | kubectl apply -f -
