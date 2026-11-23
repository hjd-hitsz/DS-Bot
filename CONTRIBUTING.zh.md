# 参与开发

[English](CONTRIBUTING.md) · 中文

[研究文档](RESEARCH.md) 记录已验证的功能、行为证据和后续目标。[AGENTS.md](AGENTS.md) 给开发者和 AI 接手者说明项目约定。

`main` 是个人 Fork 的集成分支。可以直接提交小改动，也可以开实验分支和 PR。提交说明交代改了什么、为何需要、怎样验证即可。日常变更进入 [hjd-hitsz/DS-Bot](https://github.com/hjd-hitsz/DS-Bot)。同步上游时从 `upstream` 取代码，保留本项目的数据和行为验证。

依赖、编译、测试、服务和试验全部在 Docker 中执行。使用 [Docker 指南](docker/README.md) 的源码热重载与检查命令。服务端和运行时提示词改动要跑原生 DSH 冒烟测试。日后改评分、账本或审查权限时，也要核对数据库重启、并发重试和角色边界。

已有功能的问题和研究提案可以进 [Fork Issues](https://github.com/hjd-hitsz/DS-Bot/issues)。涉及实际用户或凭据的材料用合成样例复现。需要补充证据时，把规则、观察结果和可重跑的入口一起记录。
