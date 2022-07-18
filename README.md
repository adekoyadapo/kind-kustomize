# KIND KUSTOMIZE DEMO
*Demo implementation of kutomize templating on KIND local cluster*
### Steps
- Deploy kind cluster
    - creates cluster with 3 nodes and ports 80 and 443 expose for ingress
    - Deploys nginx ingress and metrics server
    - Label nodes for NodeSelector in the kubernetes manifest
```
./kind-cluster.sh
```
- Run wrapper to create namespace and deploy manifests per environment
```
./k-wrapper.sh dev overlays/development/.
./k-wrapper.sh stage overlays/staging/.
./k-wrapper.sh prod overlays/production/.
# usage - ./k-wrapper.sh <namespace> <environment kustomization files path>
