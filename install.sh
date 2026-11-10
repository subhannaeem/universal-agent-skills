#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
SRC="$ROOT/skills"
BUNDLE=""
GLOBAL=0

for a in "$@"; do
  case "$a" in
    --global) GLOBAL=1 ;;
    wordpress) BUNDLE="wordpress" ;;
    *) echo "Usage: $0 [wordpress] [--global]"; exit 1 ;;
  esac
done

if [ "$GLOBAL" = 1 ]; then
  TARGETS=("$HOME/.claude/skills" "$HOME/.codex/skills" "$HOME/.copilot/skills")
else
  TARGETS=("$PWD/.claude/skills" "$PWD/.agents/skills" "$PWD/.github/skills")
fi

for t in "${TARGETS[@]}"; do
  mkdir -p "$t"
  if [ "$BUNDLE" = "wordpress" ]; then
    for s in "$SRC"/wp-*; do cp -R "$s" "$t"/; done
  else
    cp -R "$SRC"/. "$t"/
  fi
  echo "Installed to $t"
done
