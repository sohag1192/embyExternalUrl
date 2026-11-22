[English](README.md) | [简体中文](README.zh-Hans.md)

---

# embyAddExternalUrl

### Emby 调用外部播放器服务端脚本 (Nginx + NJS)

本项目通过 Nginx 的 **njs 模块** 运行 JavaScript 脚本，在 Emby 媒体详情元数据接口 (`/Users/{userId}/Items/{itemId}`) 的响应中动态注入外部播放器链接到 `ExternalUrls` 数组。所有 Emby 官方客户端均可直接显示并调用外部播放器，无需客户端安装任何插件或脚本。

---

## ✨ 主要特性

- **全客户端支持**：支持 Windows、macOS、Android、iOS、Apple TV 及兼容的智能电视端官方 Emby 客户端。
- **免客户端配置**：服务端统一反向代理并修改元数据，客户端无需越狱或安装油猴脚本。
- **协议跳转支持**：内置 `/redirect2external` 路由，支持将流地址转换为各播放器专用协议头（`potplayer://`、`vlc://`、`mpv://` 等）。
- **版本与压制组标签**：自动从媒体版本名称中提取标签（如 `BluRay`、`REMUX`、`WEB-DL`）与压制组信息，外链名称清晰易选。
- **无缝整合**：可单独运行，也可直接集成到 `emby2Alist` 中共存运行。

---

## 🚀 部署方式（任选一种）

### 方式一：单独部署（Docker）

此方式启动独立的 Nginx 容器，反向代理已有的 Emby 服务。

#### 1. 目录结构
```plaintext
embyAddExternalUrl/
├── docker-compose.yml
└── nginx/
    ├── nginx.conf
    └── conf.d/
        ├── emby.conf
        └── externalUrl.js
```

#### 2. 修改配置
- 编辑 `nginx/conf.d/externalUrl.js`：
  - `serverAddr`：修改为您的 Emby 公网访问地址（如 `https://emby.yourdomain.com`）。如果前置有反代且传递了 `Host` 标头，通常可保留默认自动提取。
  - `tags` 与 `groups`：从视频版本名中提取的关键字，用作外链显示的标识名。
  - `useRealFileName`：是否重写为真实文件名（需配合 `emby2Alist`）。
- 编辑 `nginx/conf.d/emby.conf`：
  - `set $emby http://172.17.0.1:8096;`：按实际情况修改为您源 Emby 服务的内网 IP 与端口。
- 编辑 `docker-compose.yml`：
  - 默认映射宿主机 `8097` 端口，可按需修改。

#### 3. 启动容器
```bash
docker-compose up -d
```

#### 4. 访问测试
通过 `http://宿主机IP:8097`（或经由外部反代）访问 Emby，在任意视频详情页底部即可看到注入的外部播放器按钮。

#### 5. 查看日志
```bash
docker logs -f nginx-embyUrl 2>&1 | grep -E "js:|error"
```

---

### 方式二：与 emby2Alist 整合并共存

如果您已部署了 `emby2Alist`，可直接将此模块合并，无需多开容器：

1. 将 `nginx/conf.d/externalUrl.js` 复制到 `emby2Alist/nginx/conf.d/` 目录下（与 `emby.js` 同级）。
2. 编辑 `emby2Alist/nginx/conf.d/emby.conf`：
   - 在文件最顶部添加：
     ```nginx
     js_import addExternalUrl from externalUrl.js;
     ```
   - 在 `server { ... }` 块内、`location /` 指令上方，加入 `## addExternalUrl SETTINGS ##` 配置块：
     ```nginx
     ## addExternalUrl SETTINGS ##
     location ~* /Users/(.*)/Items/(.*)$ {
         proxy_buffering off;
         js_body_filter  addExternalUrl.addExternalUrl buffer_type=string;
         proxy_pass $emby;
         proxy_pass_request_body off;
         proxy_http_version 1.1;
         proxy_set_header Upgrade $http_upgrade;
         proxy_set_header Connection "upgrade";
         proxy_set_header Host $host;
         proxy_set_header X-Real-IP $remote_addr;
         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
         proxy_set_header X-Forwarded-Proto $scheme;
         proxy_set_header X-Forwarded-Protocol $scheme;
         proxy_set_header X-Forwarded-Host $http_host;
         proxy_set_header Accept-Encoding "identity";
         proxy_set_header X-Original-URI $request_uri;
         js_header_filter addExternalUrl.HeaderFilter;
     }

     location ~* /redirect2external {
         js_content addExternalUrl.redirectUrl;
     }
     ## addExternalUrl SETTINGS ##
     ```
3. 重载 Nginx 配置：
   ```bash
   nginx -s reload
   ```
4. 直接通过 `emby2Alist` 对应的端口访问 Emby，即可同时享受网盘直链播放与外部播放器调用能力。

---

## ⚠️ 注意事项与局限

- 不支持部分老旧 TV 客户端（因其详情页本身缺少外部媒体数据库链接渲染区域）。
- 需注意部分智能电视内置 WebView 对自定义 Scheme 协议拉起的兼容性限制。
- 如需在网页端获得带图标的精致按钮与一键调用体验，推荐配合使用 [embyWebAddExternalUrl](../embyWebAddExternalUrl/README.zh-Hans.md)。
