# Docker 部署

从仓库根目录构建这个 Fork。宿主机提供 Docker Engine、Docker Compose 和浏览器。镜像打包当前检出的 DS Bot 源码，并运行自带的 DSH Web。默认 DSH 版本为 `0.2.2-rc.1`。模型由 DSH 原生提供方接入，PI Agent、PI ACP 和宿主机模型代理均无需安装。

DSH 随附的 `llm-pi-ai` 是模型协议适配器，用于接入 OpenAI 兼容服务。它由 DSH 进程调用，团队、会话和工具仍由 DSH 执行。

## 启动与登录

```sh
cp .env.example .env
docker compose -p ds-bot-research up -d --build
docker compose -p ds-bot-research logs ds-bot
```

默认网页为 `http://127.0.0.1:13080/`。首次登录从本机日志找到带一次性 token 的 DSH Web 链接，把内部端口替换为宿主机端口 13080。浏览器获得登录凭据后，可使用常规 URL。运行配置、登录链接和密钥留在自己的设备上。

在**设置 → 模型**配置一个 DSH 原生提供商，即可给 Chief 发任务并用产品内的组队工具。如果使用 DeepSeek，可在忽略的 `.env` 中设置 `DEEPSEEK_API_KEY`。兼容 Messages 的服务可同时设置 `DEEPSEEK_BASE_URL`。其他提供商由 DSH 的模型设置管理。旧实验数据如保存了 `local-acp-*` 路由，需在迁移副本中将相关 Bot 改选原生提供商，保留原历史供比较。

`.env.example` 列出了端口、监听、信任域名和 DSH 版本的配置。服务默认只在回环地址发布。需要远程访问时，为自己的 HTTPS 反代设置绑定地址、浏览器使用的域名及 WebSocket 转发。工作期间，Bot 能访问容器内对其开放的文件，故只挂载本团队的资料。

## 持久化与升级

Compose 项目独立拥有两个命名卷。`data` 保存 DSH 配置、团队、会话和登录状态，`workspace` 保存 Bot 的工作文件。更改项目名会使用另一组卷。正式工作、源码开发以及各实验组应使用不同的 Compose 项目。

```sh
git pull --ff-only
docker compose -p ds-bot-research up -d --build
```

启动入口将 profile 中的 DS Bot 指向当前镜像里已安装的插件。重新构建后，旧卷中的团队、会话和模型配置继续读取，代码随镜像更新。停止可用 `docker compose -p ds-bot-research down`，默认会保留两个卷。升级前若需要可回退的备份，先停止服务，再分别导出两个命名卷。

若从上游旧 Compose 迁移，先停止旧服务并备份 `docker/data` 与 `docker/workspace`。这些旧目录不会被自动复制进新命名卷。需要沿用目录时，在本地未跟踪的 `docker-compose.override.yml` 中将它们显式挂到原容器路径。使用前核对路径和同一数据只有一个服务在使用。

```yaml
services:
  ds-bot:
    volumes:
      - ./docker/data:/data
      - ./docker/workspace:/workspace
```

## 开发与验证

[源码开发与热重载](README.dev.md) 使用不同端口与数据卷。单测、前端构件核对与 lint 使用同一套容器命令。

```sh
docker compose -p ds-bot-check run --build --rm -T checks
```

下面的冒烟测试使用正式镜像、断网容器和模拟模型，从 DSH Web 接口实际运行组队、会话和任务工具。它验证原生路线和宿主无依赖的环境。模型的真实工作行为另外用 [研究文档](../RESEARCH.md) 的协议复验。

```sh
docker compose -p ds-bot-research build ds-bot
docker run --rm --network none \
  --mount "type=bind,src=$PWD,dst=/repo,readonly" \
  --entrypoint sh ds-bot-research:local /repo/docker/smoke-native.sh
```
