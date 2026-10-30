#!/usr/bin/env bash
set -euo pipefail
# Public GitHub Release installer: no gh CLI needed. Requires pipx + Python3.
OWNER="${SCANNER_GH_OWNER:-Prithish-Ghosh}"
VERSION="${SCANNER_VERSION:-v0.2.0}"
WHEEL="org_ecr_trivy_scanner-${VERSION#v}-py3-none-any.whl"
URL="https://github.com/${OWNER}/org-ecr-scanner-dist/releases/download/${VERSION}/${WHEEL}"
if ! command -v pipx >/dev/null 2>&1; then
  echo 'pipx not found. On Ubuntu: sudo apt install pipx && pipx ensurepath' >&2
  exit 1
fi
exec pipx install --force "$URL"
