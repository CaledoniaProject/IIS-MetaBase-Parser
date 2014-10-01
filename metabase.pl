#!/usr/bin/perl

use strict;
use warnings;
use utf8;
use feature 'say';
use lib '/secure/Common/src/cpan';

use FindBin;
use lib "$FindBin::Bin/lib";
use Getopt::Long;
use Data::Dumper;
use LWP::UserAgent;
use XML::Simple;

binmode(STDOUT, ':encoding(utf8)');

die "metabase /run/shm/Metabase.xml\n" unless defined $ARGV[0];

my %bindings;
my $xml  = new XML::Simple;
my $data = $xml->XMLin ($ARGV[0]);
foreach (@{ $data->{MBProperty}->{IIsWebServer} })
{
    next unless defined $_->{ServerBindings};

    my ($id) = ($_->{Location} =~ /W3SVC\/(\d+)/i);
    $bindings{$id} = $_->{ServerBindings};
}

foreach (@{ $data->{MBProperty}->{IIsWebVirtualDir} })
{
    next unless defined $_->{Path};

    my ($id) = ($_->{AppRoot} =~ /W3SVC\/(\d+)/i);

    say 'Physical Path: ', $_->{Path};
    say 'Domain name:  ';
    for (split /\s+/, $bindings{$id})
    {
        if (/:(\d+):(.*)\s*/)
        {
            if (length ($2) == 0)
            {
                say '    - (any) ', $1;
            }
            else
            {
                say '    - ', $2, ($1 == 80 ? '' : ':' . $1);
            }
        }
    }

    say "\n";
}
