---
name: plan-first-tdd-change
description: "Deliver any feature, change or bug fix the disciplined way: fresh branch from main in every affected repo, a deep written plan that follows the existing code's rules, an assumptions list the user must accept before any code, failing tests first, then the smallest implementation that makes only those tests pass, with no unrelated lines changed. Works in Claude Code, OpenAI Codex and GitHub Copilot. Use when the user asks to plan and implement a feature or fix, asks for test-first / TDD work, says 'do not change extra code', or asks for a plan plus assumptions before implementation."
argument-hint: "[feature or issue description] [branch name]"
---

# Plan-first, test-first, minimal change

A gated workflow. Each gate needs its output on disk before the next starts.
**Never skip Gate 3 (assumptions approval).** No product code, test code or
migration is written before the user approves the assumptions.

## Gate 0: Branches

1. Find every repo the change touches (server, client, shared libs).
2. In each: `git status --porcelain` must be empty. If not, stop and ask;
   never stash, reset or discard the user's work.
3. `git fetch origin`, then create the branch from the **latest remote main**
   (or the base branch the user names):
   `git checkout main && git merge --ff-only origin/main && git checkout -b <branch>`.
   Branch names cannot contain spaces: turn "broadcast re-implementation" into
   `broadcast-re-implementation`. Use the same name in every repo.
4. Do not push, open PRs or deploy unless the user asks.

## Gate 1: Learn the rules of the existing code

Before designing anything, read:
- Project instructions: `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`,
  `CONTRIBUTING.md`, README, and any project memory files they point to.
- Lint/format config, test config, CI workflow, and how a single test file runs.
- The current implementation of the area being changed, end to end
  (route → validation → action/service → model/DB → events/jobs → API
  resource → client service → state → screen). Record file:line references.
- 2–3 existing examples of the same kind of thing (a list screen, an endpoint,
  a test) to copy their patterns: naming, folder, response shape, error
  handling, i18n, theming, test fixtures.

Use read-only subagents for wide searches when the host supports them; keep
only their conclusions.

## Gate 2: Deep plan (written to disk)

Write `PLAN.md` in the project's planning folder (or the one the user names).
Sections, in order:

1. **Goal** in the user's own words, and the acceptance criteria as a numbered
   list of observable behaviors.
2. **Current behavior map**: how it works today, with file:line references.
3. **Target behavior**: per actor (e.g. user, admin, system), the flow
   after the change, including concurrency and failure cases.
4. **Change list**: per repo, per file: what is added or changed and why, each
   item traced to an acceptance criterion. Prefer adding over rewriting; reuse
   existing actions, events, components, translations and helpers.
5. **Explicitly not changed**: things that stay as they are, and existing code
   that becomes unused but is left in place unless removing it is required.
6. **Data and API contract**: new or changed endpoints, payloads, statuses,
   columns, events, channels, push types. Backward compatibility with
   installed app versions.
7. **Test plan**: each test named, the file it goes in, the criterion it
   proves, and why it fails today. Cover happy path, permission/eligibility,
   concurrency/race, and the regressions most at risk.
8. **Risks and rollout**: migrations, config, feature flags, old clients,
   deploy order (server before client), rollback.
9. **Assumptions** (see Gate 3) and **open questions**.

## Gate 3: Assumptions approval (hard stop)

Present a numbered list of every assumption the plan depends on: business
rules, edge cases, what stays the same, data choices, UI wording, what
"done" means. For each give the default you will use and its effect.
Ask the user to **accept, reject or advise** each one (accepting all at once
is fine). Then stop and wait.

- Do not start Gate 4 until the user answers.
- Update `PLAN.md` with the answers; a rejected assumption changes the plan
  and may need a new assumption, which goes back to the user.

## Gate 4: Tests first, and prove they fail

1. Write only the tests from the test plan, in the project's existing test
   style and folders. Use isolated fixtures; never touch shared/production data.
2. Run only those tests (targeted command, quiet output). Every new test must
   **fail for the expected reason** (missing route, wrong status, missing
   screen), not because of a typo or broken setup. Fix setup errors until
   the failure is the real one.
3. Save the failing output summary (test name → failure reason) to
   `TEST_LOG.md`. If a test passes before implementation, it proves nothing:
   rewrite it or drop it and tell the user.

## Gate 5: Minimal implementation

1. Implement exactly the change list. Write the smallest code that makes the
   failing tests pass while following the existing conventions.
2. Rules:
   - No refactors, renames, reformatting, import reordering, comment cleanup or
     drive-by fixes outside the change list.
   - No new dependencies unless the plan and the user approved them.
   - Do not modify existing tests to make them pass; if an existing test
     legitimately conflicts with an approved behavior change, stop and tell
     the user which test and why before changing it.
   - Do not edit generated files, lockfiles or unrelated config.
3. Run the new tests until they pass, then the existing tests for the touched
   modules once. Record results in `TEST_LOG.md`.

## Gate 6: Diff audit

1. `git diff --stat` and `git diff` in every repo.
2. Every changed line must trace to a change-list item or a test. Revert any
   line that does not (whitespace, formatting, stray edits).
3. Run the project's linter/formatter only on changed files, and only if the
   project already uses it; do not reformat untouched code.
4. Commit only when the user asks.

## Gate 7: Report

Short report: branches, files changed per repo, tests added (failed before →
pass after), existing tests run, anything not verified (device, staging,
real push), and remaining open questions. Do not claim more than was run.

## Host notes

| Host | Subagents for reading | Task list | Ask the user |
|---|---|---|---|
| Claude Code | `Agent` (Explore / Plan) | `update_plan` / todo tool | `AskUserQuestion` or plain message, then stop |
| OpenAI Codex | built-in subagents if enabled, else read directly | `update_plan` | plain message, then end the turn |
| GitHub Copilot | `runSubagent` where available | todo tool | plain message, then end the turn |

Skill install paths (same folder copied to each): `~/.claude/skills/`,
`~/.codex/skills/`, `~/.agents/skills/`, `~/.copilot/skills/`.
