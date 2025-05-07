# AWS Project on Kubernetes, Docker, and EC2

This repository contains an AWS-based project that demonstrates the deployment of applications using Kubernetes, Docker, and EC2 instances. Below is a step-by-step guide to set up and run the project.

---

## Prerequisites

1. **AWS Account**: Ensure you have an active AWS account.
2. **CLI Tools**:
    - AWS CLI
    - kubectl
    - Docker
3. **IAM Role**: Create an IAM role with necessary permissions for EC2, EKS, and S3.
4. **Key Pair**: Generate an AWS key pair for EC2 access.

---

## Steps to Set Up the Project

### 1. Launch EC2 Instance
- Log in to the AWS Management Console.
- Navigate to the EC2 dashboard and launch an instance.
- Choose an Amazon Linux 2 or Ubuntu AMI.
- Attach the IAM role created earlier.
- SSH into the instance using the key pair.

### 2. Install Docker
- Update the package manager:
  ```bash
  sudo apt update && sudo apt upgrade -y
  ```
- Install Docker:
  ```bash
  sudo apt install docker.io -y
  ```
- Start and enable Docker:
  ```bash
  sudo systemctl start docker
  sudo systemctl enable docker
  ```

### 3. Install Kubernetes Tools
- Install `kubectl`:
  ```bash
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x kubectl
  sudo mv kubectl /usr/local/bin/
  ```
- Verify installation:
  ```bash
  kubectl version --client
  ```

### 4. Set Up EKS Cluster
- Create an EKS cluster using AWS CLI:
  ```bash
  aws eks create-cluster --name my-cluster --role-arn <IAM_ROLE_ARN> --resources-vpc-config subnetIds=<SUBNET_IDS>,securityGroupIds=<SECURITY_GROUP_IDS>
  ```
- Update kubeconfig:
  ```bash
  aws eks update-kubeconfig --region <REGION> --name my-cluster
  ```

### 5. Build and Push Docker Image
- Create a Dockerfile for your application.
- Build the Docker image:
  ```bash
  docker build -t <image-name>:<tag> .
  ```
- Push the image to Amazon ECR:
  ```bash
  aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account_id>.dkr.ecr.<region>.amazonaws.com
  docker tag <image-name>:<tag> <account_id>.dkr.ecr.<region>.amazonaws.com/<image-name>:<tag>
  docker push <account_id>.dkr.ecr.<region>.amazonaws.com/<image-name>:<tag>
  ```

### 6. Deploy Application on Kubernetes
- Create Kubernetes deployment and service YAML files.
- Apply the configuration:
  ```bash
  kubectl apply -f deployment.yaml
  kubectl apply -f service.yaml
  ```
- Verify the deployment:
  ```bash
  kubectl get pods
  kubectl get svc
  ```

---

## Conclusion

This project demonstrates how to deploy containerized applications on AWS using Docker, Kubernetes, and EC2. Follow the steps above to replicate the setup and customize it for your use case.

For any issues or contributions, feel free to open an issue or submit a pull request.