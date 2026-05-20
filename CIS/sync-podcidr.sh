#!/bin/bash

set -e

echo "[INFO] Sync Calico BlockAffinity -> Node podCIDR"

kubectl get blockaffinities.crd.projectcalico.org -o name | while read block
do
    name=$(basename $block)

    # contoh:
    # k8s-worker1-192-168-194-64-26

    node=$(echo $name | sed -E 's/(.*)-([0-9]+-[0-9]+-[0-9]+-[0-9]+-[0-9]+)/\1/')
    cidr_raw=$(echo $name | sed -E 's/.*-([0-9]+-[0-9]+-[0-9]+-[0-9]+-[0-9]+)/\1/')

    # convert:
    # 192-168-194-64-26
    # ->
    # 192.168.194.64/26

    cidr=$(echo $cidr_raw | awk -F- '{print $1"."$2"."$3"."$4"/"$5}')

    current=$(kubectl get node $node -o jsonpath='{.spec.podCIDR}')

    if [[ "$current" == "$cidr" ]]; then
        echo "[OK] $node already has podCIDR $cidr"
        continue
    fi

    echo "[PATCH] $node -> $cidr"

    kubectl patch node $node --type merge -p "{
      \"spec\": {
        \"podCIDR\": \"$cidr\"
      }
    }"
done
