use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Test::Sysconfig',
    AUTHOR              => 'Ian Kilgore <iank@cpan.org>',
    VERSION_FROM        => 'lib/Test/Sysconfig.pm',
    ABSTRACT_FROM       => 'lib/Test/Sysconfig.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'Test::Builder::Module' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Test-Sysconfig-*' },
);
