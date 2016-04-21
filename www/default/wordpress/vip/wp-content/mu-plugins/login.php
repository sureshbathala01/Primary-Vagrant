<?php
add_filter( 'network_site_url', function ( $url ) {

	$urls_to_fix = array(
		'/wp-admin/network/',
		'/wp-login.php',
		'/wp-activate.php',
		'/wp-signup.php',
	);
	foreach ( $urls_to_fix as $maybe_fix_url ) {
		$fixed_wp_url = '/wp' . $maybe_fix_url;
		if ( false !== stripos( $url, $maybe_fix_url )
		     && false === stripos( $url, $fixed_wp_url )
		) {
			$url = str_replace( $maybe_fix_url, $fixed_wp_url, $url );
		}
	}

	return $url;

} );

add_filter( 'login_url', function ( $login_url ) {

	if ( false === strpos( $login_url, '/wp/wp-login.php' ) ) {
		$login_url = str_replace( '/wp-login.php', '/wp/wp-login.php', $login_url );
	}

	return $login_url;

} );

add_filter( 'site_url', function ( $url, $path ) {

	if ( 'wp-login.php' === $path && false === strpos( $url, '/wp/wp-login.php' ) ) {
		$url = str_replace( '/wp-login.php', '/wp/wp-login.php', $url );
	}

	return $url;

}, 10, 2 );
