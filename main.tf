terraform {
  required_version = ">= 1.6.0"

  cloud {
    organization = "KAIROSYNQ-ANALYTIX"

    workspaces {
      name = "terraform-github"
    }
  }

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

variable "github_org" {
  description = "GitHub organization to manage"
  type        = string
}

# Auth: set env var GITHUB_TOKEN locally (PAT with repo/admin:org scopes).
# In TFC, set GITHUB_TOKEN as a sensitive workspace variable instead.
provider "github" {
  owner = var.github_org
}
