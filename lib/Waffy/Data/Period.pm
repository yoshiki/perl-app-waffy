package Waffy::Data::Period;

use strict;
use warnings;
use base qw( Waffy::Data::Base );
use Waffy::ObjectDriver::Driver;

__PACKAGE__->install_properties({
    columns     => [qw( id service last_crawled_at )],
    datasource  => 'period',
    primary_key => [ qw( id ) ],
    driver      => Waffy::ObjectDriver::Driver->driver,
});

1;
