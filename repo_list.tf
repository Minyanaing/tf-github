# Edit this file to add/change repos. Nothing else needs to change.
locals {
  repositories = {
    "tf-github" = {
      visibility                       = "public"
      description                      = "Manages GitHub org: repos, teams, access"
      branches                         = ["main"]
      required_approving_review_count  = 0
      has_issues                       = true
      has_projects                     = true
      has_wiki                         = true
      allow_merge_commit               = false
      allow_rebase_merge               = false
      allow_squash_merge               = true
      delete_branch_on_merge           = true
    }
    "tf-terraform" = {
      visibility                       = "public"
      description                      = "Manages Terraform Cloud: projects, teams, workspaces"
      branches                         = ["main"]
      required_approving_review_count  = 0
      has_issues                       = true
      has_projects                     = true
      has_wiki                         = true
      allow_merge_commit               = false
      allow_rebase_merge               = false
      allow_squash_merge               = true
      delete_branch_on_merge           = true
    }
    "data-platform" = {
      visibility                       = "private"
      description                      = "Repo with practice codes for Workflows, dbt run on ECS for redshift, Snowflake dbt deployments"
      branches                         = ["main"]
      required_approving_review_count  = 0
      has_issues                       = true
      has_projects                     = true
      has_wiki                         = true
      allow_merge_commit               = false
      allow_rebase_merge               = false
      allow_squash_merge               = true
      delete_branch_on_merge           = true
    }

    # "my-app" = {
    #   visibility                       = "private"
    #   description                      = "App with staged envs"
    #   branches                         = ["main", "main_qa", "main_prod"]
    #   required_approving_review_count  = 1
    #   has_issues                       = true
    #   has_projects                     = true
    #   has_wiki                         = false
    #   allow_merge_commit               = false
    #   allow_rebase_merge               = false
    #   allow_squash_merge               = true
    #   delete_branch_on_merge           = true
    # }
  }
}
