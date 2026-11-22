[English](README.md) | [简体中文](README.zh-Hans.md)

---

# embyAddExternalUrl

### Emby External Player Server Script (Nginx + NJS)

This component uses the **Nginx NJS module** to run a server-side JavaScript filter that intercepts Emby metadata API responses (`/Users/{userId}/Items/{itemId}`). It dynamically injects external player launch links into the media's `ExternalUrls` array, enabling external player buttons across all official Emby clients without modifying the client applications.

---

## ✨ Features

- **Universal Client Support**: Works with official Emby clients on Windows, macOS, Android, iOS, Apple TV, and compatible Smart TVs.
- **Zero Client Modification**: Injects links directly into server responses; clients automatically display the external links in their media detail view.
- **Protocol Redirection**: Provides a built-in `/redirect2external` endpoint to format and redirect playback URLs to external player URI schemes (`potplayer://`, `vlc://`, `mpv://`, etc.).
- **Multi-Version Tagging**: Automatically extracts version tags (`BluRay`, `REMUX`, `WEB-DL`) and release groups to label external links clearly.
- **Seamless Coexistence**: Can run standalone or integrated directly into `emby2Alist`.

---

## 🚀 Deployment Methods (Choose One)

### Method 1: Standalone Deployment (Docker)

The standalone service runs an Nginx container with NJS enabled, reverse proxying your existing Emby server.

#### 1. Configuration Files
The setup includes:
```plaintext
embyAddExternalUrl/
├── docker-compose.yml
└── nginx/
    ├── nginx.conf
    └── conf.d/
        ├── emby.conf
        └── externalUrl.js
```

#### 2. Configure Settings
- Edit `nginx/conf.d/externalUrl.js`:
  - `serverAddr`: Set to your external Emby public URL (e.g., `https://emby.yourdomain.com`). If running behind another reverse proxy that passes the `Host` header, this can often be left as default.
  - `tags` & `groups`: Keywords extracted from media version titles as labels for external links.
  - `useRealFileName`: Set to `true` if your downstream player requires real file names for subtitle matching (requires `emby2Alist` rewrite).
- Edit `nginx/conf.d/emby.conf`:
  - `set $emby http://172.17.0.1:8096;`: Adjust the IP/port of your upstream Emby server if necessary.
- Edit `docker-compose.yml`:
  - Maps port `8097` by default. Adjust host port if needed.

#### 3. Start the Container
```bash
docker-compose up -d
```

#### 4. Access and Verify
Connect your Emby client or browser to port `8097` (or through your reverse proxy domain). Open any video details page, scroll to the external links section, and you will see the external player launch buttons.

#### 5. View Logs
```bash
docker logs -f nginx-embyUrl 2>&1 | grep -E "js:|error"
```

---

### Method 2: Integration with emby2Alist

If you are already running `emby2Alist`, you can merge `embyAddExternalUrl` without running an extra container:

1. Copy `nginx/conf.d/externalUrl.js` into your `emby2Alist/nginx/conf.d/` directory (at the same level as `emby.js`).
2. Open `emby2Alist/nginx/conf.d/emby.conf`:
   - At the top of the file, add:
     ```nginx
     js_import addExternalUrl from externalUrl.js;
     ```
   - Inside the `server { ... }` block, above the `location /` directive, insert the `## addExternalUrl SETTINGS ##` section from `embyAddExternalUrl/nginx/conf.d/emby.conf`:
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
3. Reload Nginx:
   ```bash
   nginx -s reload
   ```
4. Access Emby via your `emby2Alist` port to enjoy both direct cloud streaming and external player launch links.

---

## ⚙️ Configuration Reference

In `nginx/conf.d/externalUrl.js`:

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `serverAddr` | string | `https://bpking.top` | Publicly accessible URL of your Emby server |
| `tags` | array | `['BluRay', 'REMUX', 'WEB-DL']` | Version keywords to extract for button labeling |
| `groups` | array | `['CMCT', 'WIKI', 'Z0N3', ...]` | Release group keywords |
| `useRealFileName` | boolean | `false` | Whether to rewrite stream link to real filename |

---

## ⚠️ Notes & Limitations

- Older TV clients that do not render external database links will not display the injected buttons.
- TV clients with restrictive internal webview implementations may prevent custom URI scheme redirects.
- For browser-based playback, pair with [embyWebAddExternalUrl](../embyWebAddExternalUrl/README.md) for custom player icons and one-click launch capabilities.
