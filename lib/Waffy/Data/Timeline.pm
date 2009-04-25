package Waffy::Data::Timeline;

use strict;
use warnings;
use base qw( Waffy::Data::Base );
use Waffy::ObjectDriver::Driver;

__PACKAGE__->install_properties({
    columns     => [qw( id service screen_name name text created_at
                        status_id in_reply_to_status_id in_reply_to_screen_name )],
    datasource  => 'timeline',
    primary_key => [ qw( id ) ],
    driver      => Waffy::ObjectDriver::Driver->driver,
});

1;
