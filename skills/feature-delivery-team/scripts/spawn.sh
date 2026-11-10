#!/usr/bin/env bash
# Headless worker fallback for feature-delivery-team (user-approved, opt-in).
# Usage: spawn.sh <ROLE> <brief-file> [--worktree <slug>]
# Runs the brief in a fresh non-interactive session (claude | codex | copilot).
# Full log -> <dir>/logs/<ROLE>.log, final report -> <dir>/reports/<ROLE>.md,
# where <dir> is the brief's parent's parent (.feature-team/<slug>).
# Parallel: spawn.sh DEV-1 a.md & spawn.sh DEV-2 b.md & wait
# Workers get file-edit and shell rights in their working directory.
set -euo pipefail

role="${1:?role required}"
brief="${2:?brief file required}"
shift 2
slug=""
if [[ "${1:-}" == "--worktree" ]]; then slug="${2:?slug required}"; fi

brief="$(cd "$(dirname "$brief")" && pwd)/$(basename "$brief")"
dir="$(dirname "$(dirname "$brief")")"
mkdir -p "$dir/logs" "$dir/reports"
log="$dir/logs/$role.log"
report="$dir/reports/$role.md"

workdir="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
if [[ -n "$slug" ]]; then
  wt="$workdir/../.feature-team-worktrees/$slug-$role"
  branch="feature-team/$slug/$role"
  if [[ ! -d "$wt" ]]; then
    git -C "$workdir" worktree add -q -b "$branch" "$wt" 2>/dev/null \
      || git -C "$workdir" worktree add -q "$wt" "$branch"
  fi
  workdir="$(cd "$wt" && pwd)"
fi

# Same CLI as the host unless FEATURE_TEAM_RUNNER overrides.
runner="${FEATURE_TEAM_RUNNER:-}"
if [[ -z "$runner" ]]; then
  if [[ -n "${CLAUDECODE:-}" ]] && command -v claude >/dev/null; then runner=claude
  elif [[ -n "${CODEX_SANDBOX:-}" ]] && command -v codex >/dev/null; then runner=codex
  else
    for c in claude codex copilot; do command -v "$c" >/dev/null && { runner=$c; break; }; done
  fi
fi
[[ -n "$runner" ]] || { echo "spawn.sh: no claude/codex/copilot CLI on PATH; set FEATURE_TEAM_RUNNER" >&2; exit 127; }

prompt="$(cat "$brief")

Working directory: $workdir
Feature state folder: $dir
When done, write your final report (standard format, at most 150 words) to $report and also print it as your last message."

cd "$workdir"
status=0
case "$runner" in
  claude)  claude -p "$prompt" --permission-mode acceptEdits >"$log" 2>&1 || status=$? ;;
  codex)   codex exec --full-auto -C "$workdir" --output-last-message "$report.last" "$prompt" >"$log" 2>&1 || status=$? ;;
  copilot) copilot -p "$prompt" --allow-all-tools >"$log" 2>&1 || status=$? ;;
  *) echo "spawn.sh: unknown runner '$runner'" >&2; exit 2 ;;
esac

# No report written: keep codex's last message, else the log tail.
if [[ ! -s "$report" ]]; then
  if [[ -s "$report.last" ]]; then mv "$report.last" "$report"; else tail -n 30 "$log" >"$report"; fi
fi
rm -f "$report.last"

echo "$role [$runner] exit=$status report=$report log=$log"
exit "$status"
