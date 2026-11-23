# DS Bot · AI 团队研究

[English](README.md) · 中文

这个个人 Fork 把 DS Bot 作为 AI 员工与公司管理的研究平台。我们观察负责人如何派工和裁决，能兑现的奖惩如何影响跨任务行为，以及直属用户的外部审查怎样发现团队遗漏。运行环境是 Docker，模型由 DeepSeek Harness（DSH）的原生提供方接入。

现在可以自行组队、交接工作和按任务返工。同一个员工的某项工作被退回时，其他已经提交的工作及记录可以保留。**通用评分、薪资、资源交易和独立对抗性审查是后续研究目标。** [研究进展、复验与路线图](RESEARCH.md)

## 从源码部署

安装 Docker Engine 和 Docker Compose 后，在仓库根目录执行以下命令。

```sh
cp .env.example .env
docker compose -p ds-bot-research up -d --build
```

浏览器入口是 `http://127.0.0.1:13080/`。首次登录使用本机 Compose 日志给出的登录链接，再在**设置 → 模型**中配置 DSH 原生提供商。 [登录、数据卷、升级与验证](docker/README.md) · [开发约定](CONTRIBUTING.zh.md)

项目源自 [Fei2411/DS-Bot](https://github.com/Fei2411/DS-Bot)，基于 [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness)。[Apache 2.0 许可](LICENSE) · [第三方声明](NOTICE)
