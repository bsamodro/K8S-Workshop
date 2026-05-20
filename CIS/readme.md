### Step and Procedure for handson

1. [Prepare BigIP](BigIP-Preparation.md)

2. [Deploy CIS](CIS-Deployment.md)

3. [Test and Validate Arcadia Apps](Arcadia-Deployment.md)

---
### Environment

| Hostname           | HostIP     | Access  | Username | Password     |
|--------------------|------------|---------|----------|--------------|
| k8s-Master1        | 10.1.1.4   | webshell|          |              |
| bigipA.f5demo.id   | 10.1.1.7   | TMUI    | admin    | f5demo#1     |
| client             | 10.1.1.11  | firefox |          |              |


- TMOS Version : 17.1
- k8s Version : 1.33.12
- CIS Version : 2.20.3
- AS3 Version : 3.56.0

---

### Reference

Latest CIS Guide (Compatibility matrix Included) :
- https://clouddocs.f5.com/containers/latest/

How to validade AS3 in config map
- https://clouddocs.f5.com/products/extensions/f5-appsvcs-extension/latest/userguide/validate.html

---
[➡️ Next](BigIP-Preparation.md)
