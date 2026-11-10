---
name: wp-motion-performance-audit
description: "Audit a WordPress site's animations for Core Web Vitals impact (LCP, CLS, INP), GPU-friendly properties and script loading, then list prioritized fixes. Use when the user says the site is slow, janky or shifts while loading, or wants animations checked. Works in Claude Code, OpenAI Codex and GitHub Copilot."
argument-hint: "[page URL or theme path]"
---

# Motion performance audit

Read-only by default. Report first, change code only if the user asks.

## Checklist

| Check | Pass when |
|---|---|
| Animated properties | Only `transform` and `opacity` |
| Layout shift (CLS) | Images, embeds and animated blocks have reserved size; nothing pushes content after load |
| LCP element | The hero image or text is not hidden at start (`opacity: 0`) and is not lazy-loaded |
| Script weight | Animation libraries load only on pages that use them, deferred or as modules |
| Long tasks (INP) | No scroll handler does layout reads; use `IntersectionObserver` |
| `will-change` | Used sparingly and removed after the animation |
| Reduced motion | Every animation sits inside `prefers-reduced-motion: no-preference` |

## Steps

1. List every animation: search the theme for `@keyframes`, `transition`, `animate`, `gsap`, `lottie`.
2. Run Lighthouse or PageSpeed on the key pages if the tool is available; record LCP, CLS and INP.
3. Walk the checklist and note each failure as `file:line, problem, fix`.
4. Output a short table sorted by impact (high, medium, low) and a before/after metric target.

## Rules

- Do not claim a score you did not measure.
- Mark anything not tested (real devices, slow network) as unverified.
