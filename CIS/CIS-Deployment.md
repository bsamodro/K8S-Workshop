## CIS Deployment Guide

#### This document explains how to install CIS on k8s Cluster, Integrate to BigIP and Deploy Service with LTM as Ingress 
---
Login to k8s-master1 - Webshell

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
### Change Calico Block Size (Need deep assesment in production)

Routing can be manually configured on BIG-IP. However, with a /26 segment (the default Calico setting), the allocated CIDR ranges can change dynamically. These changes may not be reflected in the BIG-IP routing configuration, which can cause service disruption if traffic is forwarded through the wrong path.

In this procedure, one of the available options is to change the Calico segment size from the default /26 to /23 or /24 to reduce the frequency of dynamic CIDR allocation changes.

1. Check callico ip allocation

   ```bash
   kubectl get blockaffinities.crd.projectcalico.org
   ```
2. Change block size from /26 to /24
   ```bash
   kubectl edit ippool default-ipv4-ippool
   ```
   change blockSize: 26 to 24

   to edit : esc + i
   
   to save : esc + :wq + enter

---
### Installing CIS Manually in OCP Cluster

1. Go to ocp-provisioner WebShell tab in chrome  and go to working Directory. We have open this tab in preparation steps
   ```bash
   cd /home/cloud-user/CIS-Workshop
   ```
2. Set project or namespace to kube-system
   ```bash
   oc project kube-system
   ```
3. Add BIG-IP credentials as OSPC secrets
   ```bash
   oc create secret generic bigip-login -n kube-system --from-literal=username=admin --from-literal=password=f5demo#1
   ```
4. Create a Cluster Role and Cluster Role Binding on the Openshift Cluster by running the command below.
   ```bash
   oc create -f https://raw.githubusercontent.com/F5Networks/k8s-bigip-ctlr/2.x-master/docs/config_examples/rbac/openshift_rbac.yaml
   ```
5. Create the Cluster admin privileges for the BIG-IP service account user with the following command:
   ```bash
   oc adm policy add-cluster-role-to-user cluster-admin -z bigip-ctlr -n kube-system
   ```
6. Review CIS Deploymment config for bigip1 and bigip2. We can check only 1 config as reference
   ```bash
   cat CIS-Deployment/cis-bigip1.yaml
   ```
7. Apply CIS Deploymment config for bigip1 and bigip2
   ```bash
   oc create -f  CIS-Deployment/cis-bigip1.yaml
   
   oc create -f  CIS-Deployment/cis-bigip2.yaml
   ```
   
###  BigIP Validation

1. Use the TMUI link of the bigip1 dan bigip2 Node, login using admin

2. Access the route configuration (Click Network -> Routes) under the **opp1-routing** partition and Confirm that all 5 expected routes are correctly displayed and active

<img width="1681" alt="Image" src="https://github.com/user-attachments/assets/442193c0-0a29-4c47-bc8e-8d8e07999539" />

---

###  Deploy Arcadia Service in OCP Cluster

1. Go to ocp-provisioner WebShell tab in chrome  and go to working Directory
   ```bash
   cd /home/cloud-user/CIS-Workshop
   ```
2. Set project or namespace to arcadia
   ```bash
   oc project arcadia
   ```
3. Review Arcadia Deployment yaml
   ```bash
   cat Arcadia/arcadia-deployment.yaml 
   ```
4. Apply Arcadia Deployment yaml
   ```bash
   oc create -f Arcadia/arcadia-deployment.yaml 
   ```
5. Review Arcadia Service yaml
   ```bash
   cat Arcadia/arcadia-svc.yaml
   ```
6. Apply Arcadia Service yaml
   ```bash
   oc create -f Arcadia/arcadia-svc.yaml
   ```
7. Review Arcadia ConfigMap yaml
   ```bash
   cat Arcadia/arcadia-cm.yaml
   ```
6. Apply Arcadia Configmap yaml
   ```bash
   oc create -f  Arcadia/arcadia-cm.yaml
   ```

---
[⬅️ Previous](BigIP-Preparation.md) | [🏠 Home](readme.md) | [➡️ Next](Arcadia-ValidationAndTest.md)
