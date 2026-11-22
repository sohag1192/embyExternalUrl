#!/usr/bin/env bash
set -euo pipefail

TAG="${1:-latest}"
REPO="${2:-sohag1192/embyExternalUrl}"
OUTPUT_FILE="${3:-release_notes.md}"
DIST_DIR="${4:-dist}"

cat << EOF > "$OUTPUT_FILE"
## 📦 Assets & Downloads

| Package | Description | Direct Download |
| :--- | :--- | :--- |
| **addExternalUrl** | Adds external player button in Emby/Jellyfin | [.tar.gz](https://github.com/${REPO}/releases/download/${TAG}/addExternalUrl.tar.gz) / [.zip](https://github.com/${REPO}/releases/download/${TAG}/addExternalUrl.zip) |
| **emby2Alist** | Intercepts Emby/Jellyfin playback to Alist direct links | [.tar.gz](https://github.com/${REPO}/releases/download/${TAG}/emby2Alist.tar.gz) / [.zip](https://github.com/${REPO}/releases/download/${TAG}/emby2Alist.zip) |
| **plex2Alist** | Intercepts Plex playback to Alist direct links | [.tar.gz](https://github.com/${REPO}/releases/download/${TAG}/plex2Alist.tar.gz) / [.zip](https://github.com/${REPO}/releases/download/${TAG}/plex2Alist.zip) |
| **embyWebAddExternalUrl** | Web Userscript & Icons | [.zip](https://github.com/${REPO}/releases/download/${TAG}/embyWebAddExternalUrl.zip) |
| **alistWebAddExternalUrl** | Alist Web Userscript | [.zip](https://github.com/${REPO}/releases/download/${TAG}/alistWebAddExternalUrl.zip) |

---

### 🚀 Quick Start Commands

#### 1. Standalone External Player (\`addExternalUrl\`)
\`\`\`bash
wget https://github.com/${REPO}/releases/download/${TAG}/addExternalUrl.tar.gz \\
  && mkdir -p ~/embyExternalUrl \\
  && tar -xzvf ./addExternalUrl.tar.gz -C ~/embyExternalUrl \\
  && cd ~/embyExternalUrl \\
  && docker-compose up -d
\`\`\`

#### 2. Emby / Jellyfin Direct Link Redirection (\`emby2Alist\`)
\`\`\`bash
wget https://github.com/${REPO}/releases/download/${TAG}/emby2Alist.tar.gz \\
  && mkdir -p ~/emby2Alist \\
  && tar -xzvf ./emby2Alist.tar.gz -C ~/emby2Alist \\
  && cd ~/emby2Alist/docker \\
  && docker-compose up -d
\`\`\`

#### 3. Plex Direct Link Redirection (\`plex2Alist\`)
\`\`\`bash
wget https://github.com/${REPO}/releases/download/${TAG}/plex2Alist.tar.gz \\
  && mkdir -p ~/plex2Alist \\
  && tar -xzvf ./plex2Alist.tar.gz -C ~/plex2Alist \\
  && cd ~/plex2Alist/docker \\
  && docker-compose up -d
\`\`\`

---

### 🔐 SHA-256 Checksums
\`\`\`text
EOF

if [ -f "${DIST_DIR}/sha256sums.txt" ]; then
  cat "${DIST_DIR}/sha256sums.txt" >> "$OUTPUT_FILE"
fi

cat << 'EOF' >> "$OUTPUT_FILE"
```
EOF

echo "Release notes written to $OUTPUT_FILE"
