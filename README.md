# Install- Setup procedure for Elastic Stack on k8s

## Prerequisites

- Nodes running ubuntu
- iSCSI enabled (<https://openebs.io/docs/user-guides/prerequisites#gke>)

> Check available storage classes: `kubectl get sc`

## How to check ElasticSearch install gone well

- check list of Es services: `kubectl get service -n $ELASTIC_STACK_NS`
- run port forward: `kubectl port-forward service/$CLUSTER_NAME-http  9200:9200  -n elasticstack`
- run `sh check-es.sh`
