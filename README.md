# Org Cloud Trivy Scanner — Distribution v0.2.0

This repository distributes the **pre-built wheel** for the organization scanner. The code-maintainer repository is `org-ecr-scanner-source` and should remain restricted. This distribution repository may be made public for simpler installation, **but Python wheels contain inspectable `.py` source files**.

## Install from the v0.2.0 public GitHub release (no `gh` required)

```bash
pipx install --force 'https://github.com/Prithish-Ghosh/org-ecr-scanner-dist/releases/download/v0.2.0/org_ecr_trivy_scanner-0.2.0-py3-none-any.whl'
scan --version
scan
```

Dependencies: Python 3.10+, pipx and Trivy executable on PATH; cloud authentication is required to access ECR or OCIR. `pipx` installs the scanner's Python SDK dependencies. `scan` chooses ECR or OCIR and supports multi-repository selection `1,3,5-7` or `all`.

## ECR multi-repo example

```bash
scan --provider ecr --profile cx-hr --region ap-south-1 \
  --repository servicestation/servicestation-dev,servicestation/servicestation-tenant-api \
  --latest --non-interactive --output-dir ./reports
```

## Oracle OCIR example

OCI API/CLI profile in `~/.oci/config` is required for repository discovery. Private image scanning also requires an OCI **auth token**, separate from API key credentials.

```bash
export OCI_OCIR_USERNAME='<namespace>/<username>'
read -rs -p 'OCI auth token: ' OCI_OCIR_AUTH_TOKEN; echo
export OCI_OCIR_AUTH_TOKEN

scan --provider ocir --oci-profile DEFAULT --region me-jeddah-1 \
  --oci-compartment ocid1.compartment.oc1..REPLACE \
  --repository backend,frontend --latest --non-interactive

unset OCI_OCIR_AUTH_TOKEN
```

For an interactive run, simply run `scan` and select Oracle OCIR; it securely prompts for any missing registry credentials.

## Maintainer: publishing v0.2.0 via GitHub UI

1. Upload updated README and installer files to the distribution repo as needed.
2. Navigate to **Releases → Draft a new release**.
3. Create tag **`v0.2.0`** based on `main` (do **not** overwrite `v0.1.0`).
4. Attach `release-assets/org_ecr_trivy_scanner-0.2.0-py3-none-any.whl` as a **release asset** and publish.
5. Open the public release URL in an incognito browser and test the installation command above.

A staging copy of the wheel is included under `release-assets/` in the ZIP. You may upload it to the release via the website; keeping wheel copies tracked in Git is not necessary.

Security: users need AWS IAM or OCI IAM pull-only permissions. Secret scanning JSON can contain sensitive match data; keep reports private. This CLI is a vulnerability scanner, not a substitute for patch testing or VAPT.
