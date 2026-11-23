# DS Bot for AI teams

English · [中文](README.zh.md)

This research fork develops DS Bot into a system for managing AI employees and teams. It studies how managers delegate and make decisions, how consequences that carry over from one task to the next affect work, and how an independent reviewer reporting to the user can challenge an entire team's decisions. DS Bot runs as a DeepSeek Harness (DSH) plugin inside Docker and uses DSH model providers directly.

The current fork can form teams, hand off work, and send one group task back for rework while preserving the same employee's accepted work. **General scoring, salaries, resource trading and independent adversarial review are the next research features.** [Research findings and roadmap (Chinese)](RESEARCH.md)

## Run from source

With Docker Engine and Docker Compose available, run the following from the repository root.

```sh
cp .env.example .env
docker compose -p ds-bot-research up -d --build
```

Open the web UI at `http://127.0.0.1:13080/`. On first use, get the one-time login link from the local Compose logs and configure a native model in **Settings → Models**. The [Docker guide](docker/README.md) covers login, volumes, upgrades and checks. [Contributing](CONTRIBUTING.md) explains the fork's development workflow.

Based on [Fei2411/DS-Bot](https://github.com/Fei2411/DS-Bot) and [DeepSeek Harness](https://github.com/deepseek-ai/deepseek-harness). [Apache 2.0 license](LICENSE) · [Notices](NOTICE)
