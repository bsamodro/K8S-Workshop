## CIS - OpenShift Workshop - CIS Deployment Guide

#### This document explains how to install CIS on OCP Cluster, Integrate to BigIP and Deploy Service with LTM as Ingress Controller

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
