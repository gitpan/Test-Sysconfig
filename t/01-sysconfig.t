#!perl

use warnings;
use strict;
use Test::More tests => 4;
use_ok( 'Test::Sysconfig' );


#use Test::Sysconfig tests => 3;

check_package('perl', 'perl installed');
check_package('FNORD-this-just-cant-be-a-real-package', 'bogus package not installed', 1);
file_contains('lib/Test/Sysconfig.pm', qr/^package Test::Sysconfig;/, 'module contains package Test::Sysconfig');
