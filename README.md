# DevOps Course – Terraform AWS Infrastructure  
**Project: `devops-course-develeap-terraformtask`**

This project demonstrates an Infrastructure-as-Code (IaC) solution using **Terraform**, developed as part of the **Develeap DevOps course**.

It provisions a dynamic, modular AWS infrastructure across multiple environments (staging, production), with full lifecycle automation and best practices.

---

##  What It Deploys

-  VPC with public subnets across 2 availability zones
-  EC2 Instances (1 or 2, configurable)
-  Security Groups for SSH and app port (3000)
-  Optional ALB (Application Load Balancer)
-  Dockerized app (`adongy/hostname-docker`) deployed via `user_data.sh`
-  Remote state management via AWS S3
-  Workspace-based environment isolation (`staging`, `prod`)
-  Fully modular Terraform structure

---

                                +-----------------------------+
                                |      Internet / Users       |
                                +-------------+---------------+
                                              |
                                              ▼
                                       +-------------+
                   +-------------------|    IGW      |----------------------+
                   | VPC               +-------------+                      |
                   |CIDR: 10.x.0.0/16        |                              |
                   |                         ▼                              |
                   |   +---------------------------------------------+      |
                   |   |      Application Load Balancer (Port 80)    |      |
                   |   |      + ALB Security Group (Port 80)         |      |
                   |   +----------------------+----------------------+      |
                   |                          |                             |
                   |          +---------------+---------------+             |
                   |          |                               |             |
                   |          ▼                               ▼             |
                   |   +--------------------+       +--------------------+  |
                   |   |     Subnet A       |       |     Subnet B       |  |
                   |   |   (Public AZ-a)    |       |   (Public AZ-b)    |  |
                   |   |  +--------------+  |       |  +--------------+  |  |
                   |   |  |   EC2 #1     |  |       |  |   EC2 #2     |  |  |
                   |   |  |  Docker App  |  |       |  |  Docker App  |  |  |
                   |   |  |  Port 3000   |  |       |  |  Port 3000   |  |  |
                   |   |  |  Shared SG   |  |       |  |  Shared SG   |  |  |
                   |   |  +--------------+  |       |  +--------------+  |  |
                   |   +--------------------+       +--------------------+  |
                   |                                                        |
                   |     Shared EC2 Security Group (Port 22, 3000)          |
                   +--------------------------------------------------------+

---

## 📁 Project Structure

```
tamir-terraform-task/
├── main.tf
├── backend.tf
├── variables.tf
├── outputs.tf
├── staging.tfvars
├── prod.tfvars
├── modules/
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── compute/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── user_data.sh
```

---

## 🚀 Getting Started

1. **Init Terraform**
   ```bash
   terraform init
   ```

2. **Select environment**
   ```bash
   terraform workspace new staging
   terraform workspace select staging
   ```

3. **Deploy**
   ```bash
   terraform apply -var-file="staging.tfvars"
   ```

4. **View outputs**
   ```bash
   terraform output
   ```

5. **Access app**  
   If `enable_alb = true`, open:
   ```
   http://<alb_dns_name>
   ```

---

## 🧹 Cleanup

```bash
terraform destroy -var-file="staging.tfvars"
terraform workspace select production
terraform destroy -var-file="prod.tfvars"
```

---

## 🔒 Security Notes

- `.terraform/`, `.tfstate`, and key files (`.pem`) are ignored via `.gitignore`
- Always destroy environments when not in use to avoid billing

---

## 📚 Concepts Demonstrated

- Modular Terraform project
- Remote backend with S3
- Terraform workspaces for multi-env
- Conditional logic (`count`, `for_each`, `enable_alb`)
- Infrastructure provisioning best practices

---

## ✍️ Author

**Tamir Kafri**  
Project built during the [Develeap](https://develeap.com/) DevOps course.

---

## 📄 License

This project is open for educational use.
