# Install- Setup procedure for Elastic Stack on k8s

## Install ECK

The script below does install/upgrade for elastic cloud operator and CRDS.

## Install/updrade ES

Elastic stack (Elasticsearch, Kibana, and others) install/config are encapsulated into a helm chart at ./elastic-stack folder.

Run the command below for install/upgrade:

`helm upgrade es ./elastic-stack --namespace elasticstack --create-namespace --install`

> To test helm template rendering: `helm template --release-name es --namespace elasticstack ./elastic-stack`
> This helm chart is self-contained, for any configuration update (version number or any), you'll only need to run helm upgrade with overrides for values.yaml

Please check helm documentation for any further details.

## How to check ElasticSearch install gone well

Please refer to the NOTES section which is displayed by `helm upgrade` cli.

## Extras

### OpenEBS

OpenEBS is the target solution for multitenant storage management for k8s and other container os.

`sh install-openebs.sh`

- Nodes running ubuntu
- iSCSI enabled (<https://openebs.io/docs/user-guides/prerequisites#gke>)

> Check available storage classes: `kubectl get sc`
