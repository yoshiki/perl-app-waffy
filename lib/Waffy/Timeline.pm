package Waffy::Timeline;

use strict;
use warnings;
use base qw( Mojo::Base );
use Waffy::Util;
use Waffy::Config;
use Net::Twitter;
use LWP::UserAgent;

__PACKAGE__->attr( 'datafile', { default => sub { path_to( 'db/timeline.db' ) } } );
__PACKAGE__->attr( 'service', { default => 'twitter' } );

sub new {
    my ( $class, $service ) = @_;
    my $self = $class->SUPER::new;
    $self->service( $service ) if $service;
    return $self;
}

sub interface {
    my $self = shift;
    my $config = Waffy::Config->new;
    my %args = ( map {
        $_ => $config->{ services }->{ $self->service }->{ $_ }
    } qw( username password apiurl apihost apirealm ) );
    return Net::Twitter->new( \%args );
}

1;
