#!/user/bin/sh

ELASTIC_STACK_NS="elasticstack"
OPERATOR_NS="elastic-system"

# Documentation https://www.elastic.co/guide/en/cloud-on-k8s/master/k8s-install-helm.html#k8s-install-helm-restricted
echo "***** INSTALLING ECK *****"

helm repo add elastic https://helm.elastic.co
helm repo update

helm install elastic-operator-crds elastic/eck-operator-crds

kubectl create namespace $ELASTIC_STACK_NS

helm install elastic-operator elastic/eck-operator -n $OPERATOR_NS --create-namespace \
  --set=installCRDs=false \
  --set=managedNamespaces="{$ELASTIC_STACK_NS}" \
  --set=createClusterScopedResources=false \
  --set=webhook.enabled=false \
  --set=config.validateStorageClass=false

  
kubectl logs -n elastic-system sts/elastic-operator