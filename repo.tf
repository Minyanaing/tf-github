resource "github_repository" "this" {
  for_each = local.repositories

  name        = each.key
  visibility  = each.value.visibility
  description = each.value.description
  auto_init   = false

  has_issues   = true
  has_projects = true
  has_wiki     = true

  allow_merge_commit = false
  allow_rebase_merge = false
  allow_squash_merge = false
}

locals {
  repo_branches = merge([
    for repo, cfg in local.repositories : {
      for branch in cfg.branches : "${repo}:${branch}" => {
        repo                             = repo
        branch                           = branch
        required_approving_review_count  = cfg.required_approving_review_count
      }
    }
  ]...)
}

resource "github_branch_protection" "this" {
  for_each = local.repo_branches

  repository_id = each.value.repo
  pattern       = each.value.branch

  required_pull_request_reviews {
    required_approving_review_count = each.value.required_approving_review_count
  }

  enforce_admins = false

  depends_on = [github_repository.this]
}
