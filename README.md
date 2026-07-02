Automated Cloud Monitoring Stack:
This project demonstrates Infrastructure as Code (IaC) and Configuration Management by automatically provisioning cloud infrastructure on AWS and deploying a containerized monitoring stack.
It uses Terraform to provision an EC2 instance and dynamically generate an inventory file, and Ansible to configure the server, install Docker, and spin up a Prometheus-based monitoring stack via Docker Compose.

Security Note:
This repository uses a .gitignore file to ensure that sensitive files like terraform.tfstate, .tfvars, and private SSH keys are never committed to version control.
