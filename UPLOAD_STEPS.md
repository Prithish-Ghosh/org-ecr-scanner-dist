# Updating your TWO existing GitHub repositories

## A. Restricted source repo: `Prithish-Ghosh/org-ecr-scanner-source`

1. Unzip `org-ecr-scanner-source-v0.2.0.zip`.
2. Upload/replace the code and docs in the existing source repository, including `src/org_ecr_scan/cli.py`, `src/org_ecr_scan/ocir.py`, `src/org_ecr_scan/trivy_runner.py`, `src/org_ecr_scan/batch_report.py`, `src/org_ecr_scan/reporter.py`, `src/org_ecr_scan/__init__.py`, `pyproject.toml`, tests and README.
3. Prefer `git clone` + `git add` + commit/push to update all nested files reliably. GitHub UI upload also works, but verify file paths, overwrites and `.github/workflows` separately.
4. Do not make the source repository public if access is restricted.

## B. Distribution repo: `Prithish-Ghosh/org-ecr-scanner-dist`

1. Update this repo's README and optional `install.sh` through the GitHub UI.
2. Go to **Releases → Draft a new release**.
3. Create new tag `v0.2.0`, base `main`.
4. Attach the exact wheel `org_ecr_trivy_scanner-0.2.0-py3-none-any.whl` from this package's `release-assets` directory.
5. Publish.
6. Verify `https://github.com/Prithish-Ghosh/org-ecr-scanner-dist/releases/tag/v0.2.0` and that the `.whl` is under Assets.
7. Teammates use the `pipx install --force` one-liner in README (requires no `gh`).

**Do not replace `v0.1.0`.** Existing installations stay at the old version until upgraded.
