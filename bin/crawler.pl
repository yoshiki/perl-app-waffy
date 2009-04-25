#!/usr/local/bin/perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
use Waffy::Service;
use Waffy::Config;

my $config = Waffy::Config->new;
for my $service_name ( keys %{ $config->{ services } } ) {
    my $service = Waffy::Service->create( $service_name );
    $service->crawl;
}
