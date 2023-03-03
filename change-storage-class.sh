
if [ -z "$TARGET_SC" ]
then
    TARGET_SC="premium-rwo"
fi

# https://kubernetes.io/docs/tasks/administer-cluster/change-default-storage-class/

echo setting storage class "'$TARGET_SC'" as default
kubectl patch storageclass $TARGET_SC -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}, "volumeBindingMode": "WaitForFirstConsumer"}'

echo "list of available storage classes"
kubectl get storageclass
