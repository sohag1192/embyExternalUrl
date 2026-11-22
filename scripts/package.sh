#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DIST_DIR="${ROOT_DIR}/${1:-dist}"

rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR"

echo "=== Packaging embyAddExternalUrl -> addExternalUrl.tar.gz & .zip ==="
cd "${ROOT_DIR}/embyAddExternalUrl"
tar -czf "${DIST_DIR}/addExternalUrl.tar.gz" docker-compose.yml README.md nginx
zip -rq "${DIST_DIR}/addExternalUrl.zip" docker-compose.yml README.md nginx

echo "=== Packaging emby2Alist -> emby2Alist.tar.gz & .zip ==="
cd "${ROOT_DIR}/emby2Alist"
tar -czf "${DIST_DIR}/emby2Alist.tar.gz" docker nginx CHANGELOG.md README.md README.zh-Hans.md
zip -rq "${DIST_DIR}/emby2Alist.zip" docker nginx CHANGELOG.md README.md README.zh-Hans.md

echo "=== Packaging plex2Alist -> plex2Alist.tar.gz & .zip ==="
cd "${ROOT_DIR}/plex2Alist"
tar -czf "${DIST_DIR}/plex2Alist.tar.gz" docker nginx CHANGELOG.md README.md README.zh-Hans.md
zip -rq "${DIST_DIR}/plex2Alist.zip" docker nginx CHANGELOG.md README.md README.zh-Hans.md

echo "=== Packaging embyWebAddExternalUrl -> embyWebAddExternalUrl.zip ==="
cd "${ROOT_DIR}/embyWebAddExternalUrl"
zip -rq "${DIST_DIR}/embyWebAddExternalUrl.zip" .

echo "=== Packaging alistWebAddExternalUrl -> alistWebAddExternalUrl.zip ==="
cd "${ROOT_DIR}/alistWebAddExternalUrl"
zip -rq "${DIST_DIR}/alistWebAddExternalUrl.zip" .

echo "=== Generating Checksums ==="
cd "${DIST_DIR}"
if command -v sha256sum >/dev/null 2>&1; then
  sha256sum *.tar.gz *.zip > sha256sums.txt
elif command -v shasum >/dev/null 2>&1; then
  shasum -a 256 *.tar.gz *.zip > sha256sums.txt
fi

echo "=== Packages successfully created in ${DIST_DIR} ==="
ls -lh "${DIST_DIR}"
