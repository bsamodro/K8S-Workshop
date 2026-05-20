Deploy and Validate Arcadia Application

#### This document explains how to Deploy Arcadia Service using Config Map

---

##  Deploy Arcadia Service in k8s Cluster

On the k8s-master1 webshell, run the following command:

1. Apply Arcadia Deployment yaml
   ```bash
   kubectl apply -f ~/K8S-Workshop/CIS/Arcadia/arcadia-deployment.yaml 
   ```
2. Apply Arcadia Service yaml
   ```bash
   kubectl apply -f ~/K8S-Workshop/CIS/Arcadia/arcadia-svc.yaml
   ```
3. Apply Arcadia Configmap yaml
   ```bash
   kubectl apply -f ~/K8S-Workshop/CIS/Arcadia/arcadia-cm.yaml 
   ```
4. Check log 
   ```bash
   kubectl logs -l app=k8s-bigip-ctlr-deployment -n kube-system  --prefix=true --tail=500 
   ```

---

##  Check Arcadia Application

On TMUI GUI check network map and new arcadia partition

<img width="1717" height="421" alt="Image" src="https://github.com/user-attachments/assets/cae125db-8437-43ad-a7b4-b93450971f81" />

<img width="645" height="506" alt="Image" src="https://github.com/user-attachments/assets/744c1746-5385-4ec5-8d09-14f5b70d45d2" />

On Client Firefox open https://arcadia.demo
<img width="486" height="533" alt="Image" src="https://github.com/user-attachments/assets/54cb0c43-db27-4567-83f1-bc06574769b4" />

