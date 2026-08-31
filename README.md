# tf-github

Manages GitHub repositories and their branch protection via Terraform, run through TFC workspace `terraform-github`.

## Files

| File | Purpose |
|---|---|
| `main.tf` | provider/backend config — rarely touched |
| `repo_list.tf` | **data** — edit this to add/change repos |
| `repo.tf` | resource logic (`github_repository`, `github_branch_protection`) — rarely touched |
| `terraform.tfvars` | `github_org` value (gitignored, contains real value) |
| `terraform.tfvars.example` | committed placeholder documenting the required variable |

## One-time setup (console/UI)

1. **GitHub PAT** — Settings → Developer settings → Personal access tokens → Generate (classic). Scopes: `repo`, `admin:org`.
2. **Local auth:**
   ```cmd
   set GITHUB_TOKEN=ghp_xxxxxxxxxxxx
   ```
3. **TFC workspace variables** (console → `terraform-github` workspace → Variables) — required so VCS-triggered runs (which execute on TFC's infra, not your machine) can authenticate:
   - `github_org` — terraform variable
   - `GITHUB_TOKEN` — environment variable, **sensitive**
4. **Connect to VCS** (console → workspace → Settings → Version Control), or via code — see root [README.md](../README.md) Step 11.

## Local commands

```cmd
terraform login      # once — TFC auth, stores token in %APPDATA%\terraform.d\credentials.tfrc.json
terraform init
terraform validate
terraform plan
```

Importing a repo that already exists on GitHub (don't let `apply` try to create a duplicate):
```cmd
terraform import "github_repository.this[\"<repo-name>\"]" <repo-name>
```

## `repo_list.tf` field reference

```hcl
"repo-name" = {
  visibility                       = "public" | "private"
  description                      = string
  branches                         = ["main"]                # add main_qa/main_prod for staged envs
  enable_branch_protection         = true                     # false skips protection entirely (see gotcha below)
  required_approving_review_count  = 0                        # PR approvals required to merge
  required_status_checks           = []                       # e.g. ["ci / build"] — CI job names required to pass before merge
  has_issues                       = true
  has_projects                     = true
  has_wiki                         = true
  allow_merge_commit               = true
  allow_rebase_merge               = false
  allow_squash_merge               = false                    # at least ONE of the 3 allow_* must be true
  delete_branch_on_merge           = true
}
```
Every field is explicit per repo — no shared defaults — since different repos can reasonably need different settings.

## Adding a new repo

Add one entry to `repo_list.tf`, then:
```cmd
git checkout -b add-my-repo
git add repo_list.tf
git commit -m "add my-repo"
git push origin add-my-repo
```
Open PR → TFC auto-plans → review → merge → auto-applies (creates the repo + branch protection).

## Known gotchas

- **All 3 merge methods `false`** → GitHub API rejects it (`no_merge_method`). Keep exactly one `allow_*` true.
- **Branch protection on a private repo fails** with "Upgrade to GitHub Pro or make this repository public" — free personal accounts only get branch protection on public repos. Set `enable_branch_protection = false` for private repos until upgrading; there is then **no protection at all** — direct push to `main` is fully open.
- **`enforce_admins = true`** (hardcoded in `repo.tf`) means branch protection applies to you too, including as repo owner — no bypass. Change to `false` if owners should be exempt.
