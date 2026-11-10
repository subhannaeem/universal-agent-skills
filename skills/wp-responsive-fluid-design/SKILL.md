---
name: wp-responsive-fluid-design
description: "Make a WordPress block theme responsive with fluid typography and spacing in theme.json, mobile-first layout and container queries, then check it at standard breakpoints. Use when the user asks for a responsive, mobile-friendly or fluid WordPress design. Works in Claude Code, OpenAI Codex and GitHub Copilot."
argument-hint: "[theme or page to make responsive]"
---

# Responsive fluid design

## Steps

1. **Read `theme.json`** and list the current font sizes, spacing sizes and layout widths.
2. **Turn on fluid type and spacing**:

   ```json
   {
     "settings": {
       "typography": {
         "fluid": true,
         "fontSizes": [
           { "slug": "large", "name": "Large", "size": "2rem",
             "fluid": { "min": "1.5rem", "max": "2.5rem" } }
         ]
       },
       "spacing": { "spacingSizes": [
         { "slug": "40", "name": "Medium", "size": "clamp(1rem, 4vw, 2.5rem)" }
       ] },
       "layout": { "contentSize": "40rem", "wideSize": "72rem" }
     }
   }
   ```

3. **Mobile-first CSS**: base styles for small screens, `min-width` queries for larger ones.
4. **Use container queries** for components that live in different widths:

   ```css
   .card-wrap { container-type: inline-size; }
   @container (min-width: 32rem) { .card { display: grid; grid-template-columns: 1fr 2fr; } }
   ```

5. **Use `rem`, `clamp()` and `minmax()`**, not fixed `px` widths. Images get `max-width: 100%; height: auto`.
6. **Check at 360, 768, 1024 and 1440 px**: no horizontal scroll, tap targets at least 44 px, text at least 16 px on mobile.

## Rules

- Use theme.json tokens, not hard-coded values in CSS.
- Do not add a CSS framework.
- Change only what the responsive goal needs.
