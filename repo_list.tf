# Edit this file to add/change repos. Nothing else needs to change.
locals {
  repositories = {
    "tf-github" = {
      visibility                       = "public"
      description                      = "Manages GitHub org: repos, teams, access"
      branches                         = ["main"]
      required_approving_review_count  = 0
      required_status_checks           = [] # e.g. ["ci / build"] — GitHub Actions job names required to pass before merge
      has_issues                       = true
      has_projects                     = true
      has_wiki                         = true
      allow_merge_commit               = true
      allow_rebase_merge               = false
      allow_squash_merge               = false
      delete_branch_on_merge           = true
    }
    "tf-terraform" = {
      visibility                       = "public"
      description                      = "Manages Terraform Cloud: projects, teams, workspaces"
      branches                         = ["main"]
      required_approving_review_count  = 0
      required_status_checks           = []
      has_issues                       = true
      has_projects                     = true
      has_wiki                         = true
      allow_merge_commit               = true
      allow_rebase_merge               = false
      allow_squash_merge               = false
      delete_branch_on_merge           = true
    }
    "data-platform" = {
      visibility                       = "private"
      description                      = "Repo with practice codes for Workflows, dbt run on ECS for redshift, Snowflake dbt deployments"
      branches                         = ["main"]
      required_approving_review_count  = 0
      required_status_checks           = []
      has_issues                       = true
      has_projects                     = true
      has_wiki                         = true
      allow_merge_commit               = true
      allow_rebase_merge               = false
      allow_squash_merge               = false
      delete_branch_on_merge           = true
    }

    # "my-app" = {
    #   visibility                       = "private"
    #   description                      = "App with staged envs"
    #   branches                         = ["main", "main_qa", "main_prod"]
    #   required_approving_review_count  = 1
    #   required_status_checks           = ["ci / build"]
    #   has_issues                       = true
    #   has_projects                     = true
    #   has_wiki                         = false
    #   allow_merge_commit               = true
    #   allow_rebase_merge               = false
    #   allow_squash_merge               = false
    #   delete_branch_on_merge           = true
    # }
  }
}
