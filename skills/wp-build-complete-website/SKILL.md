---
name: wp-build-complete-website
description: "Build a complete, responsive, animated WordPress website (block theme) from a short description: plan, pages, fluid design, motion, performance and accessibility checks. Use when the user says 'build me a complete website', 'create a WordPress site for ...' or wants a full responsive, interactive WordPress site. Works in Claude Code, OpenAI Codex and GitHub Copilot."
argument-hint: "[what the site is for] [pages wanted] [style or brand notes]"
---

# Build a complete WordPress website

One description in, one finished block theme out. This skill runs the other
`wp-*` skills in order. Each gate must finish before the next starts.

## Gate 0: Brief (hard stop)

From the user's description, write `SITE_BRIEF.md` with:
- Purpose and audience, brand tone, colors and fonts (suggest defaults if none).
- Page list (default: Home, About, Services or Products, Blog, Contact).
- Features (contact form, blog, gallery, shop). Only what the user asked for.
- Assumptions, numbered, each with its default.

Show it and ask the user to **accept, reject or advise**. Stop and wait.

## Gate 1: Project setup

1. Work in a new folder (the user's chosen name). Never touch an existing site's files.
2. Create a block theme: `style.css`, `theme.json`, `templates/`, `parts/`
   (header, footer), `patterns/`, `assets/`, `functions.php`.
3. Use WordPress core blocks and patterns. No page builder, no CSS framework.
4. Optional local test: WordPress Playground or `wp-env` if available.

## Gate 2: Design system (`wp-responsive-fluid-design`)

Define colors, fluid type scale and spacing tokens in `theme.json`. Build
header, footer, navigation and a mobile menu. All values come from tokens.

## Gate 3: Pages and content

Create templates and patterns for every page in the brief. Use clear
placeholder copy (not lorem ipsum when the purpose is known) and images with
`alt` text. Use semantic HTML: one `h1` per page.

## Gate 4: Motion (`wp-animated-block-theme`)

Add scroll reveals, hover and page-transition effects with CSS first, then the
Interactivity API. Everything respects `prefers-reduced-motion`; content stays
visible without JS. Use `wp-gsap-lottie-integration` only if a requested
effect needs it.

## Gate 5: Checks

1. `wp-motion-performance-audit`: fix High items (layout-triggering
   animation, layout shift, heavy scripts).
2. `wp-accessible-ui-review`: fix High items (focus, contrast, labels, headings).
3. Check at 360, 768, 1024 and 1440 px: no horizontal scroll.
4. Validate: `php -l` on PHP files, JSON validity on `theme.json`.

## Gate 6: Hand-over

Write a short `README.md` in the theme folder: how to install (zip and upload),
how to edit pages, and what was not verified (live Lighthouse, real devices,
screen reader, hosting). Do not claim more than was run. Do not deploy, push
or commit unless the user asks.

## Rules

- No secrets, API keys or absolute local paths in any file.
- Only add plugins the user approved; prefer none.
- Use generic placeholder content; never real personal or client data.
- Keep each change traceable to the brief.
