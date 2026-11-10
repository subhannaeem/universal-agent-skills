# universal-agent-skills

Reusable skills that work in **Claude Code**, **OpenAI Codex** and **GitHub Copilot**.

## Skills

| Skill | What it does |
|---|---|
| [plan-first-tdd-change](skills/plan-first-tdd-change) | Branch from main → deep plan → you approve assumptions → failing tests → smallest possible code change |

## Install

Run from your project root (or use the global folder to install for all projects):

```bash
git clone https://github.com/subhannaeem/universal-agent-skills.git
cd universal-agent-skills && ./install.sh
```

`install.sh` copies every skill to `.claude/skills`, `.agents/skills` and `.github/skills` in the current project. Run `./install.sh --global` to install to `~/.claude/skills`, `~/.codex/skills` and `~/.copilot/skills` instead.

## Use

Ask your agent:

> Use plan-first-tdd-change to add *<your feature or fix>* on branch *<branch-name>*.

It will stop and wait for you to approve its assumptions before writing any code.

## License

MIT © Muhammad Subhan
