---
name: wp-gsap-lottie-integration
description: "Add GSAP or Lottie animations to WordPress the correct way: enqueue the library only on pages that need it, bundle or pin a version, and fall back gracefully with reduced motion. Use when CSS or the Interactivity API is not enough for the requested animation. Works in Claude Code, OpenAI Codex and GitHub Copilot."
argument-hint: "[animation] [GSAP or Lottie] [page or block]"
---

# GSAP / Lottie integration

## Steps

1. **Confirm it is needed.** Try CSS or the Interactivity API first (`wp-animated-block-theme`). Use a library only for timelines, scroll-linked scenes or vector files.
2. **Add the library locally**: install with npm and bundle it, or place a pinned copy in the theme. Do not load it from a random CDN.
3. **Enqueue conditionally** in `functions.php` or the plugin:

   ```php
   add_action( 'wp_enqueue_scripts', function () {
     if ( ! is_page( 'home' ) ) { return; }
     wp_enqueue_script( 'site-motion', get_theme_file_uri( 'assets/motion.js' ),
       array(), '1.0.0', array( 'strategy' => 'defer', 'in_footer' => true ) );
   } );
   ```

4. **Respect reduced motion**:

   ```js
   const calm = matchMedia('(prefers-reduced-motion: reduce)').matches;
   if (!calm) { gsap.from('.hero h1', { y: 40, opacity: 0, duration: 0.8 }); }
   ```

5. **Lottie**: use the lightweight player, set `loop` and `autoplay` deliberately, pause when off-screen, and show a static image when motion is reduced.
6. **Clean up**: kill timelines and ScrollTriggers on page change.
7. **Verify**: the page works with the script blocked; the library is absent on pages that do not use it.

## Rules

- Pin the version and note its license.
- Never put keys or tokens in the script.
- Do not edit WordPress core or third-party plugin files.
