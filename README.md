# KIND KUSTOMIZE DEMO
*Demo implementation of kutomize on KIND local cluster*
### Steps
- Ensure the following is setup and installed.
    - [Docker](https://docs.docker.com/get-docker/)
    - [kind](https://kind.sigs.k8s.io/)
    - [kustomize](https://kubectl.docs.kubernetes.io/installation/)
- Deploy kind cluster
    - creates cluster with 3 nodes and ports 80 and 443 expose for ingress
    - Deploys nginx ingress and metrics server
    - Label nodes for NodeSelector in the kubernetes manifest
    - The script in the repo `kind-cluster.sh` will accomplish this.
```
./kind-cluster.sh
```
- Run wrapper to create namespace and deploy manifests per environment
```
./k-wrapper.sh dev overlays/development/.
./k-wrapper.sh stage overlays/staging/.
./k-wrapper.sh prod overlays/production/.
# usage - ./k-wrapper.sh <namespace> <environment kustomization files path>
```
- The current/default image tag is labeled `1.0.0-<env>` where `env` can be `dev`, `stage` or `prod`
- To update image to the next tag `1.0.1`
```
./update-image.sh 1.0.1
```

### Versions
```
kustomize version --short
{kustomize/v4.5.7  2022-08-02T16:28:01Z  }
---
kubectl version --short
Client Version: v1.24.0
Server Version: v1.24.0
---
kind version
kind v0.14.0 go1.18.2 darwin/arm64
---
docker version --format='{{.Client.Version}}
20.10.17
```
