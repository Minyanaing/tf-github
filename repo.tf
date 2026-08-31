resource "github_repository" "this" {
  for_each = local.repositories

  name        = each.key
  visibility  = each.value.visibility
  description = each.value.description
  auto_init   = false

  has_issues   = each.value.has_issues
  has_projects = each.value.has_projects
  has_wiki     = each.value.has_wiki

  allow_merge_commit = each.value.allow_merge_commit
  allow_rebase_merge = each.value.allow_rebase_merge
  allow_squash_merge = each.value.allow_squash_merge

  delete_branch_on_merge = each.value.delete_branch_on_merge
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

  enforce_admins = true

  depends_on = [github_repository.this]
}
