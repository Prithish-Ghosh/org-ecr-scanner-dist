# GitHub upload checklist

1. In GitHub, create a PRIVATE repository `org-ecr-scanner-dist` in your organization. Add an initial empty repo, without a generated README.
2. From this folder, commit `.gitignore`, `README.md`, `install.sh`, and this guide to `main`. `release-assets/*.whl` will be skipped by Git.
3. Publish a release with tag `v0.1.0` and attach the wheel located at `release-assets/org_ecr_trivy_scanner-0.1.0-py3-none-any.whl` (GitHub web UI or `gh release create`).
4. Give DevOps colleagues **Read** access only. Only package maintainers should have write/release privileges.
5. Ask each team member to install `gh`, `pipx`, `trivy` and configure AWS credentials. They then use the one-line command in `README.md` (substitute YOUR_ORG).
6. Check `scan --version` and run `scan` to choose ECR repositories and tags.
