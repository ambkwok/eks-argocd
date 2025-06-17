#!/bin/bash

set -o errexit

## Set default configs
ARGOCD_APP_FILE=root-dev-argocd-app.yaml
BOOTSTRAP_FILE=bootstrap.sh

## Load parameters or secrets from .env file
if [ -f ".env" ]; then
    source .env
fi

echo "Waiting for ArgoCD ready"
kubectl wait --for=condition=available -n argocd deployment --all --timeout=5m 2>&1 >/dev/null
sleep 5

echo "Login via ArgoCD CLI"
kubectl port-forward svc/argocd-server -n argocd 8080:80 2>&1 >/dev/null &
sleep 5
ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
argocd login --username admin --password ${ARGOCD_PASSWORD} --grpc-web --plaintext 127.0.0.1:8080

echo "Set default namespace"
kubectl config set-context --current --namespace=argocd


echo "Add repository to ArgoCD"
if [[ ${REPOSITORY} == https://* ]]; then
  argocd repo add ${REPOSITORY} \
    --username ${REPOSITORY_OWNER} \
    --password ${REPOSITORY_TOKEN}
elif [[ ${REPOSITORY} == ssh://* ]]; then
  argocd repo add ${REPOSITORY} \
    --ssh-private-key-path ${REPOSITORY_KEY_PATH}
fi


echo "Create application via ArgoCD"
if curl --output /dev/null --silent --head --fail "$ARGOCD_APP_FILE_URL"; then
    curl -s ${ARGOCD_APP_FILE_URL} | kubectl apply -f -
else
    echo "${ARGOCD_APP_FILE} does not exist."
fi
