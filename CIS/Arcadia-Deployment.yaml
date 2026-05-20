## CIS - OpenShift Workshop - Test and Validate Arcadia Application

#### This document explains how to Test Arcadia Application that has beed deployed using CIS

---

### BigIP Validation 

Use the TMUI link of the both bigip node : bigip1 and bigip2

- login as admin -> click "Local Traffic"  -> click "Virtual Servers" -> Change Partition to "arcadia-tenant"
  arcadia-VS should be Green

<img width="1681" alt="Image" src="https://github.com/user-attachments/assets/ea3b3318-ea84-4e67-8208-437311480360" />

- Check Network Map by click  "Local Traffic" -> click "Network Map" -> New Tab will be open
  We can check VS overview, pool, ssl client, waf policy , etc

<img width="1681" alt="Image" src="https://github.com/user-attachments/assets/8d2ef06d-d615-4b64-8ac4-9d9c4b48aa12" />


### Test Application through Ubuntu Client

Use the FIREFOX link of the Ubuntu-Client Node

<img width="392" alt="Image" src="https://github.com/user-attachments/assets/b657b4bd-4d2e-437e-a26d-d22170300287" />

- Type https://arcadia.f5demo/ in address bar and click login

<img width="1681" alt="Image" src="https://github.com/user-attachments/assets/0b4ba679-fd01-4897-b108-9ea50c158faa" />

- Use username : matt and password : secret to explore Arcadia Apps

<img width="378" alt="Image" src="https://github.com/user-attachments/assets/1f599217-21f2-421e-bc2e-a29d798e9850" />

<img width="1492" alt="Image" src="https://github.com/user-attachments/assets/464da1c7-03f3-4a83-a165-43e061e7fa7f" />

### BigIP Statistic Review 

Use the TMUI link of the active bigip Node : bigip1 or bigip2

- Click  "Local Traffic" -> click "Virtual Servers" -> Pools -> Statistics -> Change Partition to "arcadia-tenant"
  
<img width="1681" alt="Image" src="https://github.com/user-attachments/assets/20d2f0e6-a1b4-43b8-bde4-a1a847380d24" />

---
[⬅️ Previous](CIS-Deployment.md) | [🏠 Home](readme.md) | [➡️ Next](CIS-Troubleshooting.md)
