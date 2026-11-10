---
name: wp-animated-block-theme
description: "Add scroll reveals, hover effects and page transitions to a WordPress block theme using CSS and the Interactivity API, with no jQuery and full prefers-reduced-motion support. Use when the user wants an animated or interactive WordPress theme or block. Works in Claude Code, OpenAI Codex and GitHub Copilot."
argument-hint: "[animation wanted] [theme or block name]"
---

# Animated block theme

## Steps

1. **Detect**: confirm a block theme (`theme.json` and `templates/` exist). If it is a classic theme, say so and stop.
2. **Pick the lightest tool**, in this order:
   1. CSS only (`transition`, `@keyframes`, `animation-timeline: view()` with a fallback).
   2. Interactivity API for state-driven motion (reveal on scroll, toggles).
   3. A library, only if 1 and 2 cannot do it (see `wp-gsap-lottie-integration`).
3. **Animate only `transform` and `opacity`.** Never animate `width`, `height`, `top` or `left`.
4. **Wrap every effect** in a motion-safe query:

   ```css
   @media (prefers-reduced-motion: no-preference) {
     .reveal { opacity: 0; transform: translateY(24px); transition: opacity .6s, transform .6s; }
     .reveal.is-visible { opacity: 1; transform: none; }
   }
   ```

5. **Scroll reveal with the Interactivity API**: add `"supports": { "interactivity": true }` to `block.json`, then:

   ```html
   <div data-wp-interactive="myTheme" data-wp-init="callbacks.observe"
        data-wp-class--is-visible="state.visible" class="reveal">…</div>
   ```

   ```js
   import { store, getElement } from '@wordpress/interactivity';
   store('myTheme', {
     state: { visible: false },
     callbacks: {
       observe() {
         const { ref } = getElement();
         new IntersectionObserver(([e], o) => {
           if (e.isIntersecting) { ref.classList.add('is-visible'); o.disconnect(); }
         }).observe(ref);
       },
     },
   });
   ```

6. **Load scripts only where used** (`viewScriptModule` in `block.json`).
7. **Verify**: reduced-motion on shows no movement; no layout shift; works with JS disabled (content stays visible).

## Rules

- Content must be visible without JS.
- No jQuery. No inline `<script>`.
- Change only the files the animation needs.
