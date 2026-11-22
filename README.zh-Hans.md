<p align="center">
  <img src="./assets/logo.svg" width="120" height="120" alt="embyExternalUrl 标志" />
</p>

<h1 align="center">embyExternalUrl</h1>

<p align="center">
  <strong>通过 Nginx NJS 与用户脚本，为 Emby、Jellyfin、Plex 与 AList 提供网盘直链播放与外部播放器调用支持</strong>
</p>

<p align="center">
  <a href="https://github.com/sohag1192/embyExternalUrl/blob/main/LICENSE"><img src="https://img.shields.io/badge/license-MIT-green.svg" alt="License: MIT" /></a>
  <img src="https://img.shields.io/badge/Nginx-NJS%20Enabled-009639?logo=nginx&logoColor=white" alt="Nginx NJS" />
  <img src="https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker&logoColor=white" alt="Docker" />
  <img src="https://img.shields.io/badge/Emby-支持-52B54B?logo=emby&logoColor=white" alt="Emby" />
  <img src="https://img.shields.io/badge/Jellyfin-兼容-00A4DC?logo=jellyfin&logoColor=white" alt="Jellyfin" />
  <img src="https://img.shields.io/badge/Plex-支持-E5A00D?logo=plex&logoColor=white" alt="Plex" />
  <img src="https://img.shields.io/badge/AList-网盘直链-1890FF" alt="AList" />
</p>

<p align="center">
  <a href="README.md"><b>English</b></a> | <a href="README.zh-Hans.md"><b>简体中文</b></a>
</p>

---

## 📖 项目简介

**embyExternalUrl** 是一套基于 Nginx NJS 反向代理与前端用户脚本的影音增强套件，主要解决两大核心需求：

1. **⚡ 网盘直链重定向播放 (`emby2Alist` / `plex2Alist`)**：  
   将 Emby、Jellyfin 或 Plex 的串流播放请求，通过 [AList](https://github.com/alist-org/alist) 重定向（302）为云盘直链（支持 115、阿里云盘、OneDrive、Google Drive、百度网盘、WebDAV 等）。播放流量直接由客户端与网盘建立连接，极大降低家庭服务器或 NAS 的带宽上传与转码 CPU 压力。

2. **🎬 调用外部播放器 (`embyAddExternalUrl` / `embyWebAddExternalUrl` / `alistWebAddExternalUrl`)**：  
   在各平台官方客户端详情页或 Web 网页端中添加调用本地优秀播放器（**PotPlayer**、**VLC**、**MPV**、**IINA**、**Infuse**、**nPlayer**、**MX Player** 等）的按钮，享受原生硬解码、HDR/杜比视界映射、外挂字幕加载及弹幕同步功能。

---

## 🧩 功能模块概览

| 模块 | 类型 | 功能说明 | 详细文档 |
| :--- | :--- | :--- | :---: |
| **`emby2Alist`** | Nginx NJS 服务端反代 | 将 Emby / Jellyfin 媒体播放请求重定向（302）至 AList 网盘直链 | [查看文档](./emby2Alist/README.zh-Hans.md) |
| **`plex2Alist`** | Nginx NJS 服务端反代 | 将 Plex 媒体播放请求重定向（302）至 AList 网盘直链 | [查看文档](./plex2Alist/README.zh-Hans.md) |
| **`embyAddExternalUrl`** | Nginx NJS 服务端过滤 | 拦截 Emby 元数据 API，在所有官方客户端详情页注入外部播放器按钮 | [查看文档](./embyAddExternalUrl/README.zh-Hans.md) |
| **`embyWebAddExternalUrl`** | 用户脚本 / 服务端注入 | 为 Emby & Jellyfin Web 端注入带精美播放器图标的调用按钮 | [查看文档](./embyWebAddExternalUrl/README.zh-Hans.md) |
| **`alistWebAddExternalUrl`** | 用户脚本 / 全局标头 | 为 AList Web 网页端添加外部播放器调用按钮 | [查看文档](./alistWebAddExternalUrl/README.zh-Hans.md) |

---

## 🎯 支持的外部播放器与对应图标

| 图标 | 播放器 | 协议 Scheme | 推荐平台 | 特色说明 |
| :---: | :--- | :--- | :--- | :--- |
| <img src="./assets/icons/icon-PotPlayer.webp" width="26" height="26" alt="PotPlayer" /> | **PotPlayer** | `potplayer://` | Windows | 强大的解码与滤镜支持，自动外挂字幕加载，支持多开实例 |
| <img src="./assets/icons/icon-MPV.webp" width="26" height="26" alt="MPV" /> | **MPV** | `mpv://` / `mpvplay://` | Windows, macOS, Linux | 极客级渲染质量与着色器，需配合 [mpv-handler](https://github.com/akiirui/mpv-handler) 注册协议 |
| <img src="./assets/icons/icon-VLC.webp" width="26" height="26" alt="VLC" /> | **VLC Media Player** | `vlc://` | 跨平台 | 经典开源全能播放器，全平台格式兼容 |
| <img src="./assets/icons/icon-IINA.webp" width="26" height="26" alt="IINA" /> | **IINA** | `iina://` | macOS | macOS 原生设计高级播放器，支持画中画与触控栏 |
| <img src="./assets/icons/icon-infuse.webp" width="26" height="26" alt="Infuse" /> | **Infuse** | `infuse://` | iOS, iPadOS, macOS, tvOS | 苹果生态旗舰影音播放器，杜比视界与 HDR 平滑呈现 |
| <img src="./assets/icons/icon-MXPlayer.webp" width="26" height="26" alt="MX Player" /> | **MX Player** | `intent://` | Android | 安卓老牌硬解播放器，手势控制便捷 |
| <img src="./assets/icons/icon-MXPlayerPro.webp" width="26" height="26" alt="MX Player Pro" /> | **MX Player Pro** | `intent://` | Android | 无广告专业版 |
| <img src="./assets/icons/icon-NPlayer.webp" width="26" height="26" alt="nPlayer" /> | **nPlayer** | `nplayer-http://` | iOS, Android | 支持 DTS/Dolby 音效认证，强大的流媒体支持 |
| <img src="./assets/icons/icon-DDPlay.webp" width="26" height="26" alt="DanDanPlay" /> | **弹弹Play** | `ddplay://` | Windows, Android | 动漫追番利器，自动匹配海量弹幕并同步展示 |
| <img src="./assets/icons/icon-StellarPlayer.webp" width="26" height="26" alt="恒星播放器" /> | **恒星播放器** | `stellar://` | Windows, macOS | 内置 HDR 画面增强与插帧高帧率支持 |
| <img src="./assets/icons/icon-OmniPlayer.webp" width="26" height="26" alt="OmniPlayer" /> | **OmniPlayer** | `omniplayer://` | macOS | Mac 平台功能全面的多格式媒体播放器 |
| <img src="./assets/icons/icon-FigPlayer.webp" width="26" height="26" alt="FigPlayer" /> | **FigPlayer** | `figplayer://` | macOS | 轻量现代 Mac 媒体播放器 |
| <img src="./assets/icons/icon-Fileball.webp" width="26" height="26" alt="Fileball" /> | **Fileball** | `fileball://` | iOS | iOS 文件管理与云端影音播放工具 |
| <img src="./assets/icons/icon-SenPlayer.webp" width="26" height="26" alt="SenPlayer" /> | **SenPlayer** | `senplayer://` | iOS, tvOS | 极简串流播放器 |
| <img src="./assets/icons/icon-Copy.webp" width="26" height="26" alt="Copy URL" /> | **复制串流链接** | 剪贴板 API | 全平台 | 一键复制附带鉴权凭据的串流直链地址 |

---

## 🖼️ 效果预览

### Emby Web 外部播放器按钮
<p align="center">
  <b>完整模式（图标 + 播放器文字）</b><br>
  <img src="./embyWebAddExternalUrl/preview/preview01.png" alt="Emby Web 完整模式" width="85%" />
</p>

<p align="center">
  <b>紧凑模式（纯图标模式）</b><br>
  <img src="./embyWebAddExternalUrl/preview/preview02.png" alt="Emby Web 紧凑模式" width="85%" />
</p>

### AList Web 外部播放器按钮
<p align="center">
  <img src="./alistWebAddExternalUrl/preview/preview01.png" alt="AList V3 预览" width="48%" />
  <img src="./alistWebAddExternalUrl/preview/preview02.png" alt="AList V2 预览" width="48%" />
</p>

---

## 🚀 部署与使用快速入门

### 1. 服务端：Emby 全客户端外链注入脚本 (`embyAddExternalUrl`)

在官方客户端详情页外部链接处自动增加外部播放器：

```bash
cd embyAddExternalUrl
docker-compose up -d
```

- 默认反向代理本机的 `http://172.17.0.1:8096`。
- 映射宿主机 `8097` 端口。
- 客户端访问 `8097` 端口，在详情页即可直接看到注入的外部播放器链接。
- 详细说明请参阅 [embyAddExternalUrl 文档](./embyAddExternalUrl/README.zh-Hans.md)。

---

### 2. 服务端：网盘直链重定向 (`emby2Alist` / `plex2Alist`)

将 Emby / Plex 播放请求转为网盘直链：

1. 按需修改 `emby2Alist/nginx/conf.d/constant.js` 中的 AList 公网地址与挂载路径映射。
2. 启动容器：
   ```bash
   cd emby2Alist/docker
   docker-compose up -d
   ```
3. 客户端连接 `8091` 端口访问媒体服务，播放时将直接 302 重定向至网盘直链。
4. Plex 用户请参阅 [plex2Alist 文档](./plex2Alist/README.zh-Hans.md)。

---

### 3. 网页端：用户脚本

增强浏览器内的 Web 详情页：

- **Emby & Jellyfin Web**:
  - 油猴脚本安装：[GreasyFork 地址（脚本 514529）](https://greasyfork.org/zh-CN/scripts/514529)。
  - 或服务端直接集成：在 `dashboard-ui/index.html` 的 `</body>` 前引入 `embyLaunchPotplayer.js`。
- **AList Web**:
  - 油猴脚本安装：[GreasyFork 地址（脚本 494829）](https://greasyfork.org/zh-CN/scripts/494829)。
  - 或在 AList 后台设置 → 全局 → 自定义头部中添加脚本引用。

---

## ❓ 常见问题解答 (FAQ)

完整疑难排查与进阶配置规则请参阅 **[FAQ.md](./FAQ.md)**：
- 挂载路径差异与 `mediaMountPath` / `mediaPathMapping` 配置指南
- Jellyfin 兼容性与特异性处理
- 内封字幕实时提取与外挂字幕加载策略
- 转码绕过与码率保留方案
- Nginx 海报图片缓存与强制刷新技巧
- 115 网盘并发线程限制与快进拖动黑屏解决方案

---

## 📄 开源许可证

本项目基于 [MIT 许可证](./LICENSE) 开源发布。
