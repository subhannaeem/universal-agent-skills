# Accessible UI review: sample-theme

Run against `sample-theme/`. Static code review plus a computed contrast ratio. No screen reader or live browser test was done.

| # | Severity | Location | Issue | WCAG | Fix |
|---|---|---|---|---|---|
| 1 | High | `style.css:1` | `outline: none` removes the focus indicator | 2.4.7 | Remove it; style `:focus-visible` |
| 2 | High | `style.css:1` | `#aaa` on white = **2.32:1** (needs 4.5:1) | 1.4.3 | Use `#595959` or darker |
| 3 | High | `index.html:11` | `<div onclick>` is not keyboard reachable | 2.1.1 | Use `<button>` |
| 4 | High | `index.html:10` | Input has only a placeholder, no label | 3.3.2 | Add `<label for>` |
| 5 | Medium | `index.html:2` | Logo `<img>` has no `alt` | 1.1.1 | Add `alt` text |
| 6 | Medium | `index.html:7-8` | Two `<h1>` elements | 1.3.1 | Keep one; use `<h2>` for the rest |
| 7 | Medium | `index.html:4` | `<h3>` appears before any `<h1>`/`<h2>` | 1.3.1 | Fix heading order |
| 8 | Medium | `style.css:2` | Infinite animation with no reduced-motion guard | 2.3.3 | Add `prefers-reduced-motion` |
| 9 | Low | `index.html` | No skip link | 2.4.1 | Add "Skip to content" link |

**Needs manual testing:** keyboard order, screen reader output, zoom to 400%. This is not a compliance claim.
