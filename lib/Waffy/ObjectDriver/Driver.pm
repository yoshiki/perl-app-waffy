package Waffy::ObjectDriver::Driver;

use strict;
use warnings;
use Data::ObjectDriver::Driver::DBI;
use Data::ObjectDriver::Driver::Cache::RAM;
use Carp;
use Waffy::Config;

sub driver {
    my $datafile = shift;
    my $config = Waffy::Config->new;
    my $fallback = Data::ObjectDriver::Driver::DBI->new(
        dsn      => $config->{ database }->{ dsn },
        username => $config->{ database }->{ username } || undef,
        password => $config->{ database }->{ password } || undef,
    );
    return Data::ObjectDriver::Driver::Cache::RAM->new(
        fallback => $fallback,
    );
}

1;
