package Waffy::Root;

use strict;
use warnings;
use base qw( Mojolicious::Controller );
use Waffy::Util;
use Waffy::Data::Timeline;

sub index {
    my $self = shift;
    my $user_agent = $self->req->headers->user_agent;
    my $sub_action = $self->ctx->handle_user_agent( $user_agent );
    return $self->render unless $sub_action; # other browsers
    my @timelines = Waffy::Data::Timeline->search( undef, {
        sort      => 'created_at',
        direction => 'descend',
        limit     => 100,
    } );
    $self->stash( timelines => \@timelines );
    $self->render( action => $sub_action );
}

1;
