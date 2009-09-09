package Text::CSV::Slurp;

use strict;
use warnings;

use Text::CSV;
use IO::Handle;

use vars qw/$VERSION/;

$VERSION = 0.5;

sub new {
  my $class = shift;
  return bless {}, $class;
}

sub load {
  my $class  = shift;
  my %opt    = @_;

  my %default = ( binary => 1 );
  %opt = (%default, %opt);

  unless (defined $opt{file} || defined $opt{filehandle} || defined $opt{string}) {
    die "Need either a file, filehandle or string to work with";
  }

  if (defined $opt{filehandle}) {
    my $io = $opt{filehandle};
    delete $opt{filehandle};
    return _from_handle($io,\%opt);
  }
  elsif (defined $opt{file}) {
    my $io = new IO::Handle;
    open($io, "<$opt{file}") || die "Could not open $opt{file} $!";
    delete $opt{file};
    return _from_handle($io,\%opt);
  }
  else {
    my @data  = split /\n/, $opt{string};
    delete $opt{string};

    my $csv   = Text::CSV->new(\%opt);
    $csv->parse(shift @data);

    my @names = $csv->fields();

    my @results;

    for my $line (@data) {
      $csv->parse($line);
      my %hash;
      @hash{@names} = $csv->fields();
      push @results, \%hash;
    }

    return \@results;
  }
}

sub _from_handle {
  my $io  = shift;
  my $opt = shift;

  my $csv = Text::CSV->new($opt);

  if ( my $head = $csv->getline($io) ) {
    $csv->column_names( $head );
  }
  else {
    die $csv->error_diag();
  }

  my @results;
  while (my $ref = $csv->getline_hr($io)) {
    push @results, $ref;
  }

  return \@results;
}

return qw/Open hearts and empty minds/;

__END__

=head1 NAME

Text::CSV::Slurp - convert CSV into an array of hashes

=head1 SUMMARY

I often need to take a CSV file that has a header row and turn it into
a perl data structure for further manipulation. This package does that
in as few steps as possible.

=head1 USAGE

 use Text::CSV::Slurp;

 my $data = Text::CSV::Slurp->load(file       => $filename   [,%options]);
 my $data = Text::CSV::Slurp->load(filehandle => $filehandle [,%options]);
 my $data = Text::CSV::Slurp->load(string     => $string     [,%options]);

Returns an array of hashes. Any extra arguments are passed to L<Text::CSV>.
The first line of the CSV is assumed to be a header row. Its fields are
used as the keys for each of the hashes.

=head1 METHODS

=head2 new

 my $slurp = Text::CSV::Slurp->new();

Instantiate an object.

=head2 load

  my $data = Text::CSV::Slurp->load(file => $filename);
  my $data = $slurp->load(file => $filename);

Load some CSV from a file, filehandle or string and return an array of hashes

=head1 DEPENDENCIES

L<Text::CSV>

L<IO::Handle>

L<Test::Most> - for tests only

=head1 LICENCE

GNU General Public License v3

=head1 SOURCE

Available at L<http://code.google.com/p/perl-text-csv-slurp/>

=head1 SEE ALSO

L<Text::CSV>

L<Spreadsheet::Read>

=cut
