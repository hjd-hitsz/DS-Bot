# Contributing

English · [中文](CONTRIBUTING.zh.md)

Start with the [research notes](RESEARCH.md) for measured results and open work. [AGENTS.md](AGENTS.md) describes the conventions for contributors and coding agents.

Use `main` for integrated work and any suitable branch for experiments. A commit or pull request can describe the outcome, reason, and checks in the contributor's language. Push authorized changes to [hjd-hitsz/DS-Bot](https://github.com/hjd-hitsz/DS-Bot). Fetch upstream changes from `upstream`, then verify compatibility with the fork's data and behavior.

Use Docker for dependencies, builds, checks, services, and experiments. The [Docker guide](docker/README.md) covers source reload and verification. Changes to the host or runtime prompt should pass the native DSH smoke test. For future scoring, ledger, and audit changes, check persistence, retry behavior, and actual role permissions.

Use [fork issues](https://github.com/hjd-hitsz/DS-Bot/issues) for bugs and research proposals. Reproduce cases with synthetic inputs and keep user data and credentials out of the public repository.
