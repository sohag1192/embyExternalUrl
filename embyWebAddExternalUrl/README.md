[English](README.md) | [简体中文](README.zh-Hans.md)

---

# embyWebAddExternalUrl

### Emby & Jellyfin Web External Player User Script

A feature-packed client/server script for Emby and Jellyfin Web clients that injects dedicated launch buttons for your favorite external video players (PotPlayer, MPV, VLC, IINA, Infuse, and more).

📜 **Latest User Script (GreasyFork):**  
[https://greasyfork.org/zh-CN/scripts/514529](https://greasyfork.org/zh-CN/scripts/514529)

---

## 🎬 Supported Players & Icons

| Icon | Player | Scheme / Protocol | Platform | Notes |
| :---: | :--- | :--- | :--- | :--- |
| <img src="./icons/icon-PotPlayer.webp" width="24" height="24" alt="PotPlayer" /> | **PotPlayer** | `potplayer://` | Windows | Supports external subtitles & multi-instance |
| <img src="./icons/icon-MPV.webp" width="24" height="24" alt="MPV" /> | **MPV** | `mpv://` / `mpvplay://` | Windows, macOS, Linux | Requires [mpv-handler](https://github.com/akiirui/mpv-handler) |
| <img src="./icons/icon-VLC.webp" width="24" height="24" alt="VLC" /> | **VLC Media Player** | `vlc://` | Cross-platform | Universal codec support |
| <img src="./icons/icon-IINA.webp" width="24" height="24" alt="IINA" /> | **IINA** | `iina://` | macOS | Modern macOS native player |
| <img src="./icons/icon-infuse.webp" width="24" height="24" alt="Infuse" /> | **Infuse** | `infuse://` | iOS, iPadOS, macOS, tvOS | High-performance Apple ecosystem player |
| <img src="./icons/icon-MXPlayer.webp" width="24" height="24" alt="MX Player" /> | **MX Player** | `intent://` | Android | Android hardware decoding |
| <img src="./icons/icon-MXPlayerPro.webp" width="24" height="24" alt="MX Player Pro" /> | **MX Player Pro** | `intent://` | Android | Pro edition without ads |
| <img src="./icons/icon-NPlayer.webp" width="24" height="24" alt="nPlayer" /> | **nPlayer** | `nplayer-http://` | iOS, Android | DTS & Dolby certified |
| <img src="./icons/icon-DDPlay.webp" width="24" height="24" alt="DanDanPlay" /> | **DanDanPlay (弹弹Play)** | `ddplay://` | Windows, Android | Synchronous anime danmaku support |
| <img src="./icons/icon-StellarPlayer.webp" width="24" height="24" alt="StellarPlayer" /> | **Stellar Player (恒星播放器)** | `stellar://` | Windows, macOS | Built-in HDR & frame interpolation |
| <img src="./icons/icon-OmniPlayer.webp" width="24" height="24" alt="OmniPlayer" /> | **OmniPlayer** | `omniplayer://` | macOS | Feature-rich Mac media player |
| <img src="./icons/icon-FigPlayer.webp" width="24" height="24" alt="FigPlayer" /> | **FigPlayer** | `figplayer://` | macOS | Lightweight modern media player |
| <img src="./icons/icon-Fileball.webp" width="24" height="24" alt="Fileball" /> | **Fileball** | `fileball://` | iOS | File manager & media player |
| <img src="./icons/icon-SenPlayer.webp" width="24" height="24" alt="SenPlayer" /> | **SenPlayer** | `senplayer://` | iOS, tvOS | Minimalist local & stream player |
| <img src="./icons/icon-Copy.webp" width="24" height="24" alt="Copy URL" /> | **Copy Stream URL** | Clipboard API | All | Copy direct stream URL to clipboard |

---

## 📌 Usage & Author Notes

1. **MPV Player**: On desktop, configure it with [mpv-handler](https://github.com/akiirui/mpv-handler) to register the URL protocol handler.
2. **PotPlayer**: Use the official latest version. PotPlayer loads external subtitles automatically; if no external subtitle is selected, it defaults to Chinese subtitles.
3. If PotPlayer fails to launch, the Windows registry association may be missing. Reinstall official PotPlayer to fix.
4. To allow multiple PotPlayer windows, remove `/current` around line 186 in `embyLaunchPotplayer.js`.
5. Recommended server deployment (no browser extension required): Place the script under `/opt/emby-server/system/dashboard-ui/` and reference it before `</body>` in `index.html`.

---

## 🚀 Deployment Methods (Choose One)

### 1. Native Server Deployment (Recommended)
- **Pros**: Zero client setup. All web browser users automatically get the external player buttons.
- **Cons**: Affects all web users; cannot be toggled per-client without script modifications.

**Steps:**
1. Open `../emby-server/system/dashboard-ui/index.html`.
2. Locate the line `<script src="apploader.js" defer></script>` near the end of the file.
3. Immediately before the closing `</body>` tag, add:
   ```html
   <script src="https://emby-external-url.7o7o.cc/embyWebAddExternalUrl/embyLaunchPotplayer.js" defer></script>
   ```
4. Refresh your browser or clear the cache.

---

### 2. Server Plugin User Script Manager (CustomCssJS)
- **Pros**: Unified across clients with admin toggle controls.
- **Cons**: Requires installing the [CustomCssJS](https://github.com/Shurelol/Emby.CustomCssJS) plugin.

---

### 3. Browser Extension (Tampermonkey / Violentmonkey)
- **Pros**: Quick to install; purely client-side; does not touch server files.
- **Cons**: Must be installed on each browser individually.

1. Install [Tampermonkey](https://www.tampermonkey.net/) in Chrome / Edge / Firefox / Safari.
2. Install the user script from [GreasyFork](https://greasyfork.org/zh-CN/scripts/514529).

---

## ⚙️ Configurable Variables

In `embyLaunchPotplayer.js`:

```js
const iconConfig = {
    // Icon source options (priority: #3 highest):
    // 1. CDN (default)
    baseUrl: "https://emby-external-url.7o7o.cc/embyWebAddExternalUrl/icons",
    // baseUrl: "https://fastly.jsdelivr.net/gh/bpking1/embyExternalUrl@main/embyWebAddExternalUrl/icons",
    // 2. Server local icons (/emby-server/system/dashboard-ui/icons)
    // baseUrl: "icons",
    // 3. Embedded Base64 icons inside iconsExt.js
    removeCustomBtns: false,
};

// Option to rewrite stream links with real filenames for better third-party player compatibility.
// Default: false. Requires nginx-emby2Alist rewrite.
const useRealFileName = false;
```

---

## 🖼️ Visual Preview

- **Emby Web (Full Text & Icon Mode — `iconOnly: false`)**  
  ![Preview 1](./preview/preview01.png)

- **Emby Web (Compact Icon Mode — `iconOnly: true`)**  
  ![Preview 2](./preview/preview02.png)

---

## 📝 CHANGELOG Highlights

- **1.1.22**: Fixed compatibility with new `vlc-protocol` and `mpvplay-protocol`.
- **1.1.21**: Fixed Jellyfin misbehavior and icon display issues.
- **1.1.20**: Adapted to Emby 4.9.0.40, refactored selectors.
- **1.1.19**: Added option to remove redundant custom switches; added icons; added STRM passthrough toggle.
- **1.1.18**: Added multi-instance PotPlayer support.
- **1.1.17**: Improved icon/text mode; isolated platform-specific data.
- **1.1.16**: Added missing `MXPlayerPro` icon.
- **1.1.15**: Added more player support; hides incompatible platform icons by default.
- **1.1.14**: Modernized Clipboard API integration.
- **1.1.13**: Fixed PotPlayer launch on Chrome ≥130, improved Chinese title encoding.
- **1.1.12**: Switched default CDN to Cloudflare Pages for improved international connectivity.
- **1.1.11**: Added `DeviceId` parameter to playback links.
- **1.1.10**: Fixed `mpv-handler` URL encoding.
- **1.1.9**: Fixed `ddplay` error for non-admin accounts.
- **1.1.8**: Fixed custom stream and download URLs.
- **1.1.7**: Added `iconOnly` compact setting; Jellyfin 10.9.6+ compatibility.
- **1.1.6**: Refactored HTML strings into structured JS objects; faster local icon fallback.
- **1.1.5**: Fixed copy link button.
- **1.1.4**: Jellyfin 10.8.13 compatibility; added `useRealFileName` option.
- **1.1.3**: Synced with `emby2Alist` `stream.ext` changes.
- **1.1.2**: Playlist compatibility; DanDanPlay & Base64 icons support; live TV page support.
- **1.1.1**: Fixed STRM playback when initial audio/video streams are missing.
