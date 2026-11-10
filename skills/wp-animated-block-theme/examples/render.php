<?php
// Content stays visible without JS; the reveal is added by the view script.
?>
<div <?php echo get_block_wrapper_attributes( array( 'class' => 'reveal' ) ); ?>
	data-wp-interactive="demo"
	data-wp-init="callbacks.observe"
	data-wp-class--is-visible="state.visible">
	<?php echo wp_kses_post( $content ); ?>
</div>
