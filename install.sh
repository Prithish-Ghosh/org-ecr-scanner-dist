#!/usr/bin/env bash
# Usage: bash install.sh YOUR_ORG/org-ecr-scanner-dist
# Requires: gh authenticated against GitHub, pipx, and Python.
set -Eeuo pipefail

repo="${1:-${SCANNER_RELEASE_REPO:-}}"
if [[ -z "$repo" || "$repo" != */* ]]; then
  echo 'Usage: bash install.sh OWNER/org-ecr-scanner-dist' >&2
  exit 2
fi
for program in gh pipx; do
  if ! command -v "$program" >/dev/null 2>&1; then
    echo "Missing prerequisite: $program. Install it and try again." >&2
    exit 1
  fi
done
if ! gh auth status >/dev/null 2>&1; then
  echo 'GitHub CLI is not authenticated. Run: gh auth login' >&2
  exit 1
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "$tmp_dir"' EXIT
printf 'Downloading latest private wheel from %s ...
' "$repo"
gh release download --repo "$repo" --pattern 'org_ecr_trivy_scanner-*.whl' --dir "$tmp_dir"
shopt -s nullglob
wheels=("$tmp_dir"/org_ecr_trivy_scanner-*.whl)
if (( ${#wheels[@]} != 1 )); then
  echo "Expected one wheel in latest release, got ${#wheels[@]}" >&2
  exit 1
fi
pipx install --force "${wheels[0]}"
echo
if command -v scan >/dev/null 2>&1; then
  scan --version
  echo 'Installation successful. Run: scan'
else
  echo 'Installation completed. If scan is not found, run: pipx ensurepath'
  echo 'Then reopen your terminal and run: scan'
fi
if ! command -v trivy >/dev/null 2>&1; then
  echo 'Note: Trivy is required for live scans. Install it separately.'
fi
