# Edit this file to add/change repos. Nothing else needs to change.
locals {
  repositories = {
    "tf-github" = {
      visibility                       = "public"
      description                      = "Manages GitHub org: repos, teams, access"
      branches                         = ["main"]
      required_approving_review_count  = 0
    }
    "tf-terraform" = {
      visibility                       = "public"
      description                      = "Manages Terraform Cloud: projects, teams, workspaces"
      branches                         = ["main"]
      required_approving_review_count  = 0
    }

    # Example multi-env repo, PR review required:
    # "my-app" = {
    #   visibility                       = "private"
    #   description                      = "App with staged envs"
    #   branches                         = ["main", "main_qa", "main_prod"]
    #   required_approving_review_count  = 1
    # }
  }
}
