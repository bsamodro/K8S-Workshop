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
<img width="436" height="702" alt="Image" src="https://github.com/user-attachments/assets/07efe9b5-7562-433e-b57e-df9dd061a44d" />

- Add k8s-cis partition
<img width="568" height="575" alt="Image" src="https://github.com/user-attachments/assets/76120802-5a91-48e4-8612-9bd7e6fe5f92" />

---

### Create a Share Object : WAF Policy and NAT Pool. These will be allocated for VS that provisioned by CIS

- Click Security -> Application Security -> Security Policies -> Policies List
<img width="568" height="455" alt="Image" src="https://github.com/user-attachments/assets/05e5f5ee-b655-4797-ae4a-d577a13c15d0" />
<img width="1292" height="225" alt="Image" src="https://github.com/user-attachments/assets/f1f9a317-bb97-4bc9-990e-46226852a9a7" />

  Configure Policy :
- Policy Name : arcadia-waf
- Policy Template : Rapid Deployment Policy
- Click Save
<img width="1067" height="631" alt="Image" src="https://github.com/user-attachments/assets/831d86ea-c50e-4a35-b135-6953f6e70123" />

- Click Local Traffic -> Address Translation -> SNAT Pool List
<img width="426" height="644" alt="Image" src="https://github.com/user-attachments/assets/5b46e519-88f2-4246-8b06-8a20eb16a4e6" />

  Configure
- Name : arcadia-snatpool
- IP Address : 10.1.10.51
<img width="585" height="366" alt="Image" src="https://github.com/user-attachments/assets/10940420-5a16-493a-8ce5-d9f8e4e67102" />

[🏠 Home](readme.md) | [➡️ Next](CIS-Deployment.md)

