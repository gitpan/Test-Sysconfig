package Test::Sysconfig;

use warnings;
use strict;

use Carp;

my $CLASS = __PACKAGE__;
use base 'Test::Builder::Module';

=head1 NAME

Test::Sysconfig - System configuration related unit tests

=head1 VERSION

Version 0.01

=cut

our $VERSION     = '0.01';
our @EXPORT      = qw(&check_package &file_contains);

=head1 SYNOPSIS

Test::Sysconfig is used to help test system configuration, ie, cfengine unit
tests.

    use Test::Sysconfig tests => 3;
    
    check_package('less', 'package less');
    check_package('emacs21', 'emacs uninstalled', 1);
    file_contains('Test/Sysconfig.pm', qr/do {local \$\//);

=head1 EXPORT

check_package
file_contains

=head1 FUNCTIONS

=head2 check_package

Takes four arguments:
  - package name
  - test name (optional, defaults to package name)
  - invert test (optional, defaults to no)
  - package manager (optional and currently ignored, defaults to dpkg)

=cut

#TODO: version
sub check_package {
    my ($pkg, $testname, $invert, $pkgmgr);
    $pkg      = shift;
    if (!$pkg) {
        carp "Package name required";
        return undef;
    }
    $testname = (shift || $pkg);
    $invert   = (shift || 0);
    $pkgmgr   = (shift || "dpkg");

    my $res = system("/usr/bin/dpkg -l $pkg 2>/dev/null|egrep '^ii' >/dev/null");
    $res = $res >> 8;  # get the actual return value

    my $tb = Test::Sysconfig->builder;
    $tb->ok($res == $invert, $testname);
}

=head2 file_contains

Takes four arguments:
  - filename
  - regex to search for
  - test name (optional, defaults to filename
  - invert test (optional, defaults to no)

=cut

sub file_contains {
    my ($filename, $regex, $testname, $invert, $res);
    $filename   = shift;
    $regex      = shift;
    if (!$filename) {
        carp "Filename required";
        return undef;
    }
    if (!$regex) {
        carp "Regex required";
        return undef;
    }
    $testname   = (shift || $filename);
    $invert     = (shift || 0);

    $res = (open my $fh, '<', $filename) or carp "Could not open $filename for reading";
    return undef unless $res;

    my $text = do {local $/; <$fh>};
    my $tb = Test::Sysconfig->builder;

    $res = ($text =~ $regex);
    $tb->ok($invert ? !$res : $res, $testname);
}

=head1 AUTHOR

Ian Kilgore, C<< <iank at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-test-cfengine at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-Sysconfig>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Test::Sysconfig

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Test-Sysconfig>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Test-Sysconfig>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-Sysconfig>

=item * Search CPAN

L<http://search.cpan.org/dist/Test-Sysconfig>

=back

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2007 Ian Kilgore, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of Test::Sysconfig
