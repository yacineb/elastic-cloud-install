
ELASTIC_STACK_NS="elasticstack"
CLUSTER_NAME="elasticsearch"

echo "list of es services"
kubectl get service -n $ELASTIC_STACK_NS

SECRET_NAME="$CLUSTER_NAME-elastic-user"
ES_PASSWORD=$(kubectl get secret $SECRET_NAME -o jsonpath='{.data.elastic}'  -n $ELASTIC_STACK_NS | base64 --decode)
curl -u "elastic:$ES_PASSWORD" -k http://localhost:9200/