import { store, getElement } from '@wordpress/interactivity';

store( 'demo', {
	state: { visible: false },
	callbacks: {
		observe() {
			const { ref } = getElement();
			const observer = new IntersectionObserver( ( [ entry ] ) => {
				if ( entry.isIntersecting ) {
					ref.classList.add( 'is-visible' );
					observer.disconnect();
				}
			} );
			observer.observe( ref );
		},
	},
} );
