
# Terraform infrastructure

Terraform code that creates an EC2 instance and a DynamoDB storage for a MongoDB collection.

If you don't have Terraform installed locally, please refer to the installation guide: [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).

To create the infrastructure, please follow the instructions below:

## Setup

First, on your AWS console, create a new user that inherits the necessary privileges by adding the user to a security group.

Now, generate a new key for the previously created user:

1. After copying the public key, set the variable below in your terminal window:

```bash
export AWS_ACCESS_KEY_ID=your_public_key
```

2. After copying the secret access key, set the variable below in your terminal window:

```bash
export AWS_SECRET_ACCESS_KEY=your_secret_access_key
```

## Build the Infrastructure

Run this command to initialize the project and build the .terraform.lock.hcl file:

```bash
terraform init
```

Plan the deployment of the infrastructure using this command:

```bash
terraform plan
```

Finally, you can create the infrastructure using this command:

```bash
terraform apply
```

## Destroy

Use this command if you wish to destroy the infrastructure:

```bash
terraform destroy
```
