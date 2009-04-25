package Waffy::Service::Wassr;

use strict;
use warnings;
use base qw( Waffy::Service );
use Waffy::Util;

sub friends_timeline {
    my ( $self, $args ) = @_;
    my $results = $self->interface->friends_timeline( $args );
    my @statuses;
    for my $tweet ( @$results ) {
        my $reply_id;
        if ( $tweet->{ reply_status_url } ) {
            $reply_id = $tweet->{ reply_status_url } =~ m#/([^/]+)?$#;
        }
        push @statuses, {
            service                 => $self->service,
            screen_name             => $tweet->{ user_login_id } || undef,
            name                    => $tweet->{ user }->{ screen_name } || undef,
            text                    => $tweet->{ text } || undef,
            created_at              => epoch2datetime( $tweet->{ epoch } ),
            status_id               => $tweet->{ rid },
            in_reply_to_status_id   => $reply_id || undef,
            in_reply_to_screen_name => $tweet->{ reply_user_login_id } || undef,
        };
    }
    return \@statuses;
}

1;
