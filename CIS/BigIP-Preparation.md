##  BigIP Preparation Guide

#### This document explains how to prepare BigIP to integrate with k8s and deploy CIS in k8s cluster

---

### AS3 Module Validation

Use the TMUI link of bigipA

<img width="370" alt="Image" src="https://github.com/user-attachments/assets/f87857b8-d526-433a-b9cd-a97348966f40" />

- login as admin -> click iApps -> click "Package Management LX" -> validate that f5-avvsvcs installed ( we use 3.56 version )

<img width="1687" alt="Image" src="https://github.com/user-attachments/assets/e16b4f93-08af-4d7a-9076-f75a177df0b3" />
  
### Create a BIG-IP partition for CIS (owner)

CIS can add a static route on the BIG-IP to reach k8s pod services via the k8s nodes.

- Click System -> Select Users -> Select Partition List -> Click "Plus" Sign
<img width="421" alt="Image" src="https://github.com/user-attachments/assets/66c707dd-29d3-45ae-99ea-908a1fbfd034" />

- Add k8s-cis partition
<img width="1023" height="686" alt="Image" src="https://github.com/user-attachments/assets/6a8513de-2c85-465b-bf12-6d3ca8eeb859" />

---
[⬅️ Previous](OCP-Preparation.md) | [🏠 Home](readme.md) | [➡️ Next](CIS-Deployment.md)

