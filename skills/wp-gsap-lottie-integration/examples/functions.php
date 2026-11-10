<?php
/**
 * Load the motion script only on the home page, deferred, in the footer.
 */
add_action( 'wp_enqueue_scripts', function () {
	if ( ! is_front_page() ) {
		return;
	}
	wp_enqueue_script(
		'site-motion',
		get_theme_file_uri( 'assets/motion.js' ),
		array(),
		'1.0.0',
		array( 'strategy' => 'defer', 'in_footer' => true )
	);
} );
