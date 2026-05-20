##  BigIP Preparation Guide

#### This document explains how to prepare BigIP to integrate with k8s and deploy CIS in k8s cluster

---

### AS3 Module Validation

Use the TMUI link of bigipA

<img width="483" height="359" alt="Image" src="https://github.com/user-attachments/assets/b596ab5f-9fb1-4e51-9a5f-53f9f1d1767f" />

- login as admin -> click iApps -> click "Package Management LX" -> validate that f5-avvsvcs installed ( we use 3.56 version )

<img width="1412" height="278" alt="Image" src="https://github.com/user-attachments/assets/ee059c82-0315-4c9b-802a-608fe2dd830c" />
  
### Create a BIG-IP partition for CIS (owner)

CIS can add a static route on the BIG-IP to reach k8s pod services via the k8s nodes.

- Click System -> Select Users -> Select Partition List -> Click "Plus" Sign

- Add k8s-cis partition
<img width="1023" height="686" alt="Image" src="https://github.com/user-attachments/assets/6a8513de-2c85-465b-bf12-6d3ca8eeb859" />

---

### Create a Share Object : WAF Policy and NAT Pool. These will be allocated for VS that provisioned by CIS

- Click Security -> Application Security -> Security Policies -> Policies List
  
  Configure Policy :
- Policy Name : arcadia-waf
- Policy Template : Rapid Deployment Policy
- Click Save

[⬅️ Previous](OCP-Preparation.md) | [🏠 Home](readme.md) | [➡️ Next](CIS-Deployment.md)

