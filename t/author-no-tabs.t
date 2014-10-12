
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for testing by the author');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.09

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Text/CSV/Slurp.pm',
    't/001_load.t',
    't/002_bad.t',
    't/003_create.t',
    't/author-no-tabs.t',
    't/data/bad_whitespace.csv',
    't/data/valid.csv',
    't/release-eol.t',
    't/release-pod-syntax.t'
);

notabs_ok($_) foreach @files;
done_testing;
