## CIS Deployment Guide

#### This document explains how to install CIS on k8s Cluster, Integrate to BigIP and Deploy Service with LTM as Ingress 
---
Login to k8s-master1 - Webshell

<img width="475" height="454" alt="Image" src="https://github.com/user-attachments/assets/329b4b05-ebaa-4cff-96ec-ebbc5a0d499a" />

login as ubuntu
```bash
su - ubuntu
```
---
### Prepare CIS environment in k8s cluster
1. Clone the GitHub repository
   ```bash
   git clone https://github.com/F5Networks/k8s-bigip-ctlr.git
   git clone https://github.com/bsamodro/K8S-Workshop.git
   ```
2. Create a Cluster Role, Cluster Role Binding and Service account for CIS Controller
   ```bash
   kubectl create -f k8s-bigip-ctlr/docs/config_examples/rbac/k8s_rbac.yml
   ```
3. Optionally, Install Custom Resource Definitions for CIS Controller if you are using custom resources 
   ```bash
   export CIS_VERSION=v2.20.3
   kubectl create -f https://raw.githubusercontent.com/F5Networks/k8s-bigip-ctlr/${CIS_VERSION}/docs/config_examples/customResourceDefinitions/customresourcedefinitions.yml
   ```
4. Create the kubernetes secret with BIG IP credentials
   ```bash
   kubectl create secret generic f5-bigip-ctlr-login -n kube-system --from-literal=username=admin --from-literal=password=f5demo#1 --from-literal=url=10.1.10.7
   ```
---
### deploy CIS
1. Review CIS configuration
   ```bash
   cat ~/K8S-Workshop/CIS/BigIPCtrl/k8s-bigip-ctlr.yaml 
   ```
2. Deploy CIS yaml
   ```bash
   kubectl apply -f K8S-Workshop/CIS/BigIPCtrl/k8s-bigip-ctlr.yaml
   ```
3. Check CIS realtime log
   ```bash
   kubectl logs -f -l app=k8s-bigip-ctlr-deployment -n kube-system --prefix=true
   ```
   Ctrl + C to stop logs
   
5. Check pod status
   ```bash
   kubectl get pods -n kube-system
   ```
6. Check again all logs to see all messages
   ```bash
   kubectl logs -l app=k8s-bigip-ctlr-deployment -n kube-system  --prefix=true --tail=500 
   ```
Note that you may see logs similar to the following

[pod/k8s-bigip-ctlr-deployment-c9d6949b8-mb2dl/k8s-bigip-ctlr] 2026/05/20 15:12:29 [DEBUG] podCIDR is not found on node k8s-worker2 so not adding the static route for node

This indicates that CIS is unable to detect the Calico block allocation information. As a result, CIS cannot automatically provision the required static routes on BIG-IP.
To allow CIS to create the routes correctly, we need to map the Calico block allocation into the Kubernetes podCIDR field using the following configuration.

5. Run this Script
   ```bash
   chmod +x ~/K8S-Workshop/CIS/sync-podcidr.sh
   ~/K8S-Workshop/CIS/sync-podcidr.sh
   ```

6. Check BIGIP route under k8s-partition
<img width="1713" height="608" alt="Image" src="https://github.com/user-attachments/assets/b035a142-50d2-4393-8736-133e168879a8" />

---

[⬅️ Previous](BigIP-Preparation.md) | [🏠 Home](readme.md) | [➡️ Next](Arcadia-ValidationAndTest.md)
