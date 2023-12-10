<!-- markdownlint-disable -->
# Terraform AWS EC2 & Load Balancer Modules
<!-- markdownlint-restore -->
This Terraform project provides modular infrastructure code for deploying AWS EC2 instances and an associated Load Balancer.

# Deployment Elements

- Create a VPC

- Create 3 Public Subnets

- Create Internet Gateway

- Configure Public Route Tables

- Set up Security Group

- Deploy 3 EC2 Instances

- Target Group creation and Application Load Balancer


## Setup Instructions
**Step 1. Clone the Repository:**

git clone https://github.com/aadirai02/terraform-aws-ec2-alb-module.git

cd terraform-aws-ec2-alb-module

**Step 2. Customize Configuration:**

Navigate to the ec2-tech-test in the Devlopment environment in the env/ directory. Customize the variables.tf file with your preferred settings.

**Step 3. Run Terraform Commands:**

terraform init

terraform plan

terraform apply

**Step 4. Clean Up:**

terraform destroy
