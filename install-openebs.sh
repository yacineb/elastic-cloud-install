#!/user/bin/sh

echo "**** INSTALLING OPENEBS ****"

# Documentation: https://openebs.io/docs/user-guides/quickstart

helm repo add openebs https://openebs.github.io/charts
helm repo update
helm install openebs --namespace openebs openebs/openebs --create-namespace