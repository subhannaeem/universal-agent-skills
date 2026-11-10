// Assumes GSAP is bundled with this file (for example via npm and a bundler).
import { gsap } from 'gsap';

const reduced = window.matchMedia( '(prefers-reduced-motion: reduce)' ).matches;

if ( ! reduced ) {
	gsap.from( '.hero h1', { y: 40, opacity: 0, duration: 0.8, ease: 'power2.out' } );
	gsap.from( '.hero p', { y: 24, opacity: 0, duration: 0.8, delay: 0.15 } );
}
