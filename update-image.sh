#!/bin/bash

#update dev
cd overlays/development && kustomize edit set image node=aade/node:$1-dev

#update stage
cd ../staging && kustomize edit set image node=aade/node:$1-stage

#update production
cd ../production && kustomize edit set image node=aade/node:$1-prod
