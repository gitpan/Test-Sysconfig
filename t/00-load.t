#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Test::Sysconfig' );
}

diag( "Testing Test::Sysconfig $Test::Sysconfig::VERSION, Perl $], $^X" );
