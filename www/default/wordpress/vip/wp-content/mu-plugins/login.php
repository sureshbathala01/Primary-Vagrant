<?php
add_filter( 'network_site_url', function ( $url, $path, $scheme ) {

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
}, 10, 3 );

add_filter( 'login_url', function ( $login_url, $redirect ) {

	$login_url = str_replace( '/wp-login.php', '/wp/wp-login.php', $login_url );

	return $login_url;
}, 10, 2 );

add_filter( 'site_url', function ( $url, $path ) {

	if ( 'wp-login.php' === $path ) {

		$url = str_replace( '/wp-login.php', '/wp/wp-login.php', $url );

	}

	return $url;

}, 10, 4 );
