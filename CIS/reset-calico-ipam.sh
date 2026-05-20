#!/bin/bash

echo "[INFO] Starting Calico IPAM reset (BlockAffinity + Pods)"

# 1. Delete all BlockAffinities
echo "[STEP 1] Deleting all BlockAffinities..."
for ba in $(kubectl get blockaffinities.crd.projectcalico.org -o name); do
    echo "Deleting $ba"
    kubectl delete $ba
done

# 2. Delete all pods (ALL namespaces)
echo "[STEP 2] Deleting all pods in all namespaces..."
kubectl delete pod -A --all

echo "[INFO] Waiting for system pods to recover..."
sleep 20

# 3. Check remaining BlockAffinities
echo "[STEP 3] Current BlockAffinities:"
kubectl get blockaffinities.crd.projectcalico.org

echo "[DONE] Calico IPAM reset triggered"
