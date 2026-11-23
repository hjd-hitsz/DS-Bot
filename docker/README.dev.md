# 在 Docker 中开发 DS Bot

生产只使用 [正式镜像](README.md)。需要跟踪源码修改时，从仓库根目录启用开发配置。

```sh
PUID=$(id -u) PGID=$(id -g) DS_BOT_PORT=13081 docker compose -p ds-bot-dev \
  -f docker-compose.yml -f docker-compose.dev.yml up -d --build ds-bot
```

页面位于 `http://127.0.0.1:13081/`，独立使用 `ds-bot-dev` 项目的数据和工作卷。登录方式与生产相同。主机服务的源码修改会触发容器内 DSH 重启。界面源码修改会在容器里重建构件，刷新浏览器即可加载。正在执行的回合可能随重启中断。

需要生成并提交全部构件时，用带完整仓库副本及 Linux 依赖的检查镜像构建，再复制输出。

```sh
docker compose -p ds-bot-check build checks
docker compose -p ds-bot-check run --rm -T \
  -v "$PWD/ds-bot:/out" checks \
  sh -ec 'npm run build && cp client.js office.js link.js /out/'
```

可以用 [Docker 指南](README.md#开发与验证) 中的容器测试核对改动。在依赖清单改变后重建镜像。开发服务结束时使用相同的 Compose 文件和项目名停止。

```sh
docker compose -p ds-bot-dev -f docker-compose.yml -f docker-compose.dev.yml down
```
