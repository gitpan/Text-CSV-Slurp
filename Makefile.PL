

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'Text::CSV::Slurp',
    VERSION_FROM => 'lib/Text/CSV/Slurp.pm', # finds \$VERSION
    AUTHOR       => 'Robbie Bow (robbiebow@cpan.org)',
    ABSTRACT     => 'Turn a chunk of CSV into an array of hashes',
    PREREQ_PM    => {
                     'Test::Most'   => undef,
                     'Text::CSV'    => 1.06,
                     'IO::Handle'   => undef,
                    },
);
