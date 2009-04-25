package Waffy::Service::Twitter;

use strict;
use warnings;
use base qw( Waffy::Service );
use DateTime::Format::RSS;

sub make_opts {
    my $self = shift;
    my %opts;
    my ( $period ) = Waffy::Data::Period->search( { service => $self->service } );
    $opts{ since } = $period->last_crawled_at if $period;
    return \%opts;
}

sub friends_timeline {
    my ( $self, $args ) = @_;
    my $results = $self->interface->friends_timeline( $args );
    my @statuses;
    for my $tweet ( @$results ) {
        # Sun Mar 15 06:45:47 +0000 2009
        my $dt = DateTime::Format::RSS->parse_datetime( $tweet->{ created_at } );
        push @statuses, {
            service                 => $self->service,
            screen_name             => $tweet->{ user }->{ screen_name } || undef,
            name                    => $tweet->{ user }->{ name } || undef,
            text                    => $tweet->{ text } || undef,
            created_at              => $dt->set_time_zone( 'local' )->datetime,
            status_id               => $tweet->{ id },
            in_reply_to_status_id   => $tweet->{ in_reply_to_status_id } || undef,
            in_reply_to_screen_name => $tweet->{ in_reply_to_screen_name } || undef,
        };
    }
    return \@statuses;
}

1;
