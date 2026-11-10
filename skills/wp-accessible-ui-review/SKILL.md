---
name: wp-accessible-ui-review
description: "Review a WordPress theme or page for accessibility: focus states, keyboard use, ARIA, color contrast, headings, alt text and reduced motion, and report findings with file:line and fixes. Use when the user asks for an accessibility, WCAG or a11y check. Works in Claude Code, OpenAI Codex and GitHub Copilot."
argument-hint: "[theme path or page URL]"
---

# Accessible UI review

Report first. Fix only what the user approves.

## Checklist (WCAG 2.2 AA)

- **Keyboard**: every interactive element is reachable with Tab and has a visible `:focus-visible` style.
- **Skip link** to main content exists.
- **Headings**: one `h1`, no skipped levels.
- **Contrast**: text 4.5:1, large text and UI parts 3:1.
- **Images**: meaningful `alt`; decorative images use `alt=""`.
- **Forms**: every field has a label; errors are announced and not shown by color alone.
- **ARIA**: used only when native HTML cannot do the job; menus and toggles set `aria-expanded`.
- **Motion**: autoplay over 5 seconds can be paused; `prefers-reduced-motion` is honored.
- **Targets**: at least 24 px (44 px preferred on touch).

## Steps

1. Read the templates, parts and CSS; run an automated check (axe or Lighthouse) if available.
2. Walk the checklist and note failures as `file:line, issue, WCAG criterion, fix`.
3. Output a table sorted by severity, then ask which fixes to apply.

## Rules

- Automated tools find only part of the issues; list what still needs a manual keyboard or screen-reader test.
- Do not claim WCAG compliance.
