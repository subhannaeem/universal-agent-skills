# Motion performance audit: sample-theme

Run against `sample-theme/style.css`. Measured by reading the code; Lighthouse was not run (no live site), so Core Web Vitals numbers are **not measured**.

| # | Impact | Location | Problem | Fix |
|---|---|---|---|---|
| 1 | High | `style.css:2` | `@keyframes slide` animates `left`, which forces layout every frame | Animate `transform: translateX()` instead |
| 2 | High | `style.css:5` | `transition: height` triggers layout and can cause CLS | Use `transform: scaleY()` or `grid-template-rows` |
| 3 | High | `style.css:1-2` | Infinite animation with no `prefers-reduced-motion` guard (0 found) | Wrap in `@media (prefers-reduced-motion: no-preference)` |
| 4 | Medium | `style.css:3` | Fixed `width: 1200px` image breaks small screens | `max-width: 100%; height: auto` |

**Not verified:** LCP, CLS and INP values, real-device scroll smoothness, script loading (no JS in the sample).
