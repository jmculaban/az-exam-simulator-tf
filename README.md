# Azure Exam Simulator Terraform

This directory contains the Terraform configuration for the Azure Exam Simulator infrastructure.

## What This Deploys

Reusable modules to provision:

- A resource group
- An App Service plan and Linux Web App for the backend API
- An Azure Static Web App for the frontend
- An Azure Storage account
- An Azure Database for PostgreSQL Flexible Server
- Application Insights monitoring
- A virtual network and subnet for private endpoints
- Private DNS zones for PostgreSQL and Blob Storage
- Private endpoints for PostgreSQL and Storage

## Project Layout

```text
az-exam-simulator-tf/
├── provider.tf
├── variables.tf
├── locals.tf
├── environments/
│   └── dev/
│       ├── main.tf
│       ├── locals.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── terraform.tfvars
│   └── staging/
│   └── prod/
└── modules/
    ├── app_service/
    ├── monitoring/
    ├── network/
    ├── postgres/
    ├── private_dns/
    ├── private_endpoint/
    ├── resource_group/
    ├── static_web/
    └── storage/
```

## Prerequisites

- Terraform installed
- Azure CLI installed
- An Azure subscription you can deploy into
- An authenticated Azure CLI session

Login before running Terraform:

```bash
az login
az account set --subscription "<subscription-id-or-name>"
```

## Required Variables

All environments require these input variables:

- `db_username`
- `db_password`

Set them in `environments/{env}/terraform.tfvars`:

```hcl
db_username = "your-admin-user"
db_password = "your-strong-password"
```

## Deploy to the Specific Environment

Run Terraform from `environments/{env}`.

```bash
cd tf-az-exam-simulator/environments/{env}
terraform init
terraform plan -out=tfplan
terraform apply "tfplan"
```

If you do not want to save the plan first:

```bash
terraform apply -auto-approve
```

## Destroy

To preview what will be removed:

```bash
cd tf-az-exam-simulator/environments/{env}
terraform plan -destroy
```

To destroy everything tracked by the `{env}` state:

```bash
terraform destroy
```

To destroy without an interactive confirmation prompt:

```bash
terraform destroy -auto-approve
```

## Useful Outputs

After a successful apply, the stack exposes:

- `resource_group`
- `backend_url` (currently the backend hostname)
- `frontend_hostname`
- `storage_account`
- `postgres_fqdn`

Show outputs with:

```bash
terraform output
```

## Notes

- Run Terraform separately for each environment folder.
- `terraform destroy` only removes resources tracked in the current state.
- The Static Web App module uses Azure Static Web Apps, which have region availability constraints.