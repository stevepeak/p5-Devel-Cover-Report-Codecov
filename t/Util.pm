use strict;
use warnings;
use utf8;

use lib qw(
    lib
    t/data/proj/lib
);

use Exporter 'import';

use Test::More;
use Test::Deep;
use Test::Exception;

our @EXPORT = (
    @Test::More::EXPORT,
    @Test::Deep::EXPORT,
    @Test::Exception::EXPORT,

    qw/extract_tar/,
);

sub extract_tar {
    my ($filepath, $outdir) = @_;

    require Archive::Tar;
    require Cwd;
    require Cwd::Guard;
    Cwd->import('abs_path');
    Cwd::Guard->import('cwd_guard');

    my $abs_path = abs_path($filepath);
    my $guard    = cwd_guard($outdir);

    my $tar = Archive::Tar->new;
    $tar->read($abs_path);
    $tar->extract;
}

1;
