helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

echo "installing prometheus exporter for elasticsearch"
helm upgrade es-prom-exporter --namespace elasticstack prometheus-community/prometheus-elasticsearch-exporter -f ./values.yaml --install --dry-run