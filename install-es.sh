#!/user/bin/sh


ELASTIC_STACK_NS="elasticstack"

## Installing Elastic stack
if [ -z "$ElasticStackVersion" ]
then
    ElasticStackVersion="8.6.2"
fi

if [ -z "$TARGET_SC" ]
then
    TARGET_SC="premium-rwo"
fi

echo installing elastic Search v$ElasticStackVersion


mkdir -p templates/generated
TEMPLATE_PATH='templates/generated/elasticsearch.yaml'

rm -f $TEMPLATE_PATH
cp templates/elastic-search-origin.yaml $TEMPLATE_PATH
sed -i -e "s,{{ elastic_stack_version }},$ElasticStackVersion,g" $TEMPLATE_PATH
sed -i -e "s,{{ storage_class }},$TARGET_SC,g" $TEMPLATE_PATH

kubectl apply -f $TEMPLATE_PATH --namespace=$ELASTIC_STACK_NS