#!/user/bin/sh

ELASTIC_STACK_NS="elasticstack"
OPERATOR_NS="elastic-system"

# Documentation https://www.elastic.co/guide/en/cloud-on-k8s/master/k8s-install-helm.html#k8s-install-helm-restricted
echo "***** INSTALLING ECK at ns '$OPERATOR_NS' *****"

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

  
echo "Waiting for ElasticCloud Operator to register custom resource definitions..."

crd_apmservers_status="false"
until [ "$crd_apmservers_status" = "True" ]; do sleep 1; printf "."; crd_apmservers_status=`kubectl get customresourcedefinitions apmservers.apm.k8s.elastic.co -o jsonpath='{.status.conditions[1].status}' 2>&1`; done

crd_elasticsearches_status="false"
until [ "$crd_elasticsearches_status" = "True" ]; do sleep 1; printf "."; crd_elasticsearches_status=`kubectl get customresourcedefinitions elasticsearches.elasticSearch.k8s.elastic.co -o jsonpath='{.status.conditions[1].status}' 2>&1`; done

crd_kibanas_status="false"
until [ "$crd_kibanas_status" = "True" ]; do sleep 1; printf "."; crd_kibanas_status=`kubectl get customresourcedefinitions kibanas.kibana.k8s.elastic.co -o jsonpath='{.status.conditions[1].status}' 2>&1`; done

echo 'Elastic Cloud CRD is ready!'