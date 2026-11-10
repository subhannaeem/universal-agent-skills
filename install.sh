#!/usr/bin/env bash
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)/skills"

if [ "${1:-}" = "--global" ]; then
  TARGETS=("$HOME/.claude/skills" "$HOME/.codex/skills" "$HOME/.copilot/skills")
else
  TARGETS=("$PWD/.claude/skills" "$PWD/.agents/skills" "$PWD/.github/skills")
fi

for t in "${TARGETS[@]}"; do
  mkdir -p "$t"
  cp -R "$SRC"/. "$t"/
  echo "Installed to $t"
done
