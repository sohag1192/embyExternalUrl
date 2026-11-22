<p align="center">
  <img src="./assets/logo.svg" width="120" height="120" alt="embyExternalUrl Logo" />
</p>

<h1 align="center">embyExternalUrl</h1>

<p align="center">
  <strong>Supercharge Emby, Jellyfin, Plex, and AList with Cloud Direct-Link Streaming & Universal External Player Integration</strong>
</p>

<p align="center">
  <a href="https://github.com/sohag1192/embyExternalUrl/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg" alt="License: MIT" /></a>
  <img src="https://img.shields.io/badge/Nginx-NJS%20Enabled-009639?logo=nginx&logoColor=white" alt="Nginx NJS" />
  <img src="https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker&logoColor=white" alt="Docker" />
  <img src="https://img.shields.io/badge/Emby-Supported-52B54B?logo=emby&logoColor=white" alt="Emby" />
  <img src="https://img.shields.io/badge/Jellyfin-Supported-00A4DC?logo=jellyfin&logoColor=white" alt="Jellyfin" />
  <img src="https://img.shields.io/badge/Plex-Supported-E5A00D?logo=plex&logoColor=white" alt="Plex" />
  <img src="https://img.shields.io/badge/AList-Direct%20Links-1890FF" alt="AList" />
</p>

<p align="center">
  <a href="README.md"><b>English</b></a> | <a href="README.zh-Hans.md"><b>简体中文</b></a>
</p>

---

## 📖 Overview

**embyExternalUrl** is an all-in-one suite of Nginx NJS reverse proxy scripts and web userscripts that enhances your personal media streaming setup in two major ways:

1. **⚡ Cloud Direct-Link Playback (`emby2Alist` / `plex2Alist`)**:  
   Redirects media requests from Emby, Jellyfin, or Plex directly to cloud drive high-speed direct download links via [AList](https://github.com/alist-org/alist) (supporting 115, Aliyun Drive, Google Drive, OneDrive, Baidu, WebDAV, etc.). This eliminates server bandwidth bottlenecks and offloads heavy transcoding tasks from your home server or NAS.

2. **🎬 Universal External Player Launcher (`embyAddExternalUrl` / `embyWebAddExternalUrl` / `alistWebAddExternalUrl`)**:  
   Allows launching dedicated local video players (such as **PotPlayer**, **VLC**, **MPV**, **IINA**, **Infuse**, **nPlayer**, and **MX Player**) directly from official Emby client apps or web dashboards, delivering full hardware decoding, HDR/Dolby Vision tone-mapping, external subtitle auto-loading, and anime danmaku support.

---

## 🧩 Project Modules

| Module | Type | Description | Documentation |
| :--- | :--- | :--- | :---: |
| **`emby2Alist`** | Nginx NJS Server Proxy | Intercepts Emby / Jellyfin streaming requests and redirects (302) to AList cloud direct links | [Read Guide](./emby2Alist/README.md) |
| **`plex2Alist`** | Nginx NJS Server Proxy | Intercepts Plex streaming requests and redirects (302) to AList cloud direct links | [Read Guide](./plex2Alist/README.md) |
| **`embyAddExternalUrl`** | Nginx NJS Server Filter | Injects external player launch links into Emby metadata API responses for all official clients | [Read Guide](./embyAddExternalUrl/README.md) |
| **`embyWebAddExternalUrl`** | UserScript / Server Injected | Adds customizable external player buttons with official player icons to Emby & Jellyfin Web | [Read Guide](./embyWebAddExternalUrl/README.md) |
| **`alistWebAddExternalUrl`** | UserScript / Custom Header | Adds external player launch buttons to the AList Web interface | [Read Guide](./alistWebAddExternalUrl/README.md) |

---

## 🎯 Supported External Players & Icons

| Icon | Player | Launch Protocol / Scheme | Primary Platforms | Key Features |
| :---: | :--- | :--- | :--- | :--- |
| <img src="./assets/icons/icon-PotPlayer.webp" width="26" height="26" alt="PotPlayer" /> | **PotPlayer** | `potplayer://` | Windows | Rich codec support, auto Chinese/external subtitles, multi-instance |
| <img src="./assets/icons/icon-MPV.webp" width="26" height="26" alt="MPV" /> | **MPV** | `mpv://` / `mpvplay://` | Windows, macOS, Linux | High quality rendering, custom shaders, requires [mpv-handler](https://github.com/akiirui/mpv-handler) |
| <img src="./assets/icons/icon-VLC.webp" width="26" height="26" alt="VLC" /> | **VLC Media Player** | `vlc://` | Windows, macOS, Linux, Android, iOS | Universal cross-platform open-source player |
| <img src="./assets/icons/icon-IINA.webp" width="26" height="26" alt="IINA" /> | **IINA** | `iina://` | macOS | Modern macOS native design, Touch Bar & picture-in-picture support |
| <img src="./assets/icons/icon-infuse.webp" width="26" height="26" alt="Infuse" /> | **Infuse** | `infuse://` | iOS, iPadOS, macOS, tvOS | Premium Apple player, smooth HDR & Dolby Vision playback |
| <img src="./assets/icons/icon-MXPlayer.webp" width="26" height="26" alt="MX Player" /> | **MX Player** | `intent://` | Android | Industry-standard Android hardware decoding |
| <img src="./assets/icons/icon-MXPlayerPro.webp" width="26" height="26" alt="MX Player Pro" /> | **MX Player Pro** | `intent://` | Android | Ad-free professional edition |
| <img src="./assets/icons/icon-NPlayer.webp" width="26" height="26" alt="nPlayer" /> | **nPlayer** | `nplayer-http://` | iOS, Android | DTS-HD, Dolby audio certified, robust streaming engine |
| <img src="./assets/icons/icon-DDPlay.webp" width="26" height="26" alt="DanDanPlay" /> | **DanDanPlay (弹弹Play)** | `ddplay://` | Windows, Android | Synchronous anime danmaku (bullet comments) integration |
| <img src="./assets/icons/icon-StellarPlayer.webp" width="26" height="26" alt="StellarPlayer" /> | **Stellar Player (恒星播放器)** | `stellar://` | Windows, macOS | Built-in HDR tone-mapping, frame rate doubling (SVP alternative) |
| <img src="./assets/icons/icon-OmniPlayer.webp" width="26" height="26" alt="OmniPlayer" /> | **OmniPlayer** | `omniplayer://` | macOS | Powerful macOS all-format media player |
| <img src="./assets/icons/icon-FigPlayer.webp" width="26" height="26" alt="FigPlayer" /> | **FigPlayer** | `figplayer://` | macOS | Lightweight modern media player for Mac |
| <img src="./assets/icons/icon-Fileball.webp" width="26" height="26" alt="Fileball" /> | **Fileball** | `fileball://` | iOS | Modern iOS file manager and cloud video player |
| <img src="./assets/icons/icon-SenPlayer.webp" width="26" height="26" alt="SenPlayer" /> | **SenPlayer** | `senplayer://` | iOS, tvOS | Clean, lightweight stream player for Apple platforms |
| <img src="./assets/icons/icon-Copy.webp" width="26" height="26" alt="Copy URL" /> | **Copy Stream URL** | Clipboard API | Cross-platform | Copies direct stream / playback URL with authorization tokens |

---

## 🖼️ Visual Previews

### Emby Web Player Buttons
<p align="center">
  <b>Full Mode (Icons + Player Labels)</b><br>
  <img src="./embyWebAddExternalUrl/preview/preview01.png" alt="Emby Web Full Mode" width="85%" />
</p>

<p align="center">
  <b>Compact Mode (Clean Icons Only)</b><br>
  <img src="./embyWebAddExternalUrl/preview/preview02.png" alt="Emby Web Compact Mode" width="85%" />
</p>

### AList Web Player Buttons
<p align="center">
  <img src="./alistWebAddExternalUrl/preview/preview01.png" alt="AList V3 Preview" width="48%" />
  <img src="./alistWebAddExternalUrl/preview/preview02.png" alt="AList V2 Preview" width="48%" />
</p>

---

## 🚀 Quick Start & Deployment

### 1. Server-Side: Emby External Player Link Injector (`embyAddExternalUrl`)

Injects external player launch links into official Emby client apps:

```bash
cd embyAddExternalUrl
docker-compose up -d
```

- Reverse proxies your upstream Emby server (default `http://172.17.0.1:8096`).
- Exposes port `8097` by default.
- Injects external player links under the media's "External Links" section.
- For detailed setup, see the [embyAddExternalUrl Guide](./embyAddExternalUrl/README.md).

---

### 2. Server-Side: Direct Cloud Streaming (`emby2Alist` / `plex2Alist`)

Redirects media playback requests to AList cloud direct links:

1. Configure `emby2Alist/nginx/conf.d/constant.js` with your AList address and mount paths.
2. Start via Docker:
   ```bash
   cd emby2Alist/docker
   docker-compose up -d
   ```
3. Connect your Emby client to port `8091`. Playback will be 302-redirected to cloud drive direct links.
4. For Plex, follow the [plex2Alist Guide](./plex2Alist/README.md).

---

### 3. Web Client: User Scripts

Enhance the web dashboard of Emby, Jellyfin, or AList:

- **Emby & Jellyfin Web**:
  - Install via [GreasyFork (Script 514529)](https://greasyfork.org/zh-CN/scripts/514529).
  - Or deploy server-side by adding `<script src=".../embyLaunchPotplayer.js" defer></script>` before `</body>` in `dashboard-ui/index.html`.
- **AList Web**:
  - Install via [GreasyFork (Script 494829)](https://greasyfork.org/zh-CN/scripts/494829).
  - Or paste into AList Admin Panel → Settings → Global → Custom Header.

---

## ❓ Frequently Asked Questions (FAQ)

Detailed troubleshooting and advanced configuration patterns can be found in **[FAQ.md](./FAQ.md)**:
- Path mapping (`mediaMountPath` vs `mediaPathMapping`)
- Jellyfin compatibility & differences
- Subtitle extraction (embedded vs external SRT/ASS)
- Transcoding bypass & multi-bitrate settings
- Nginx image caching & cache purging
- 115 Drive concurrent thread and seek rate-limiting solutions

---

## 📄 License

This project is licensed under the [MIT License](./LICENSE).
