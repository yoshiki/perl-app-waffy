package Waffy::Service;

use strict;
use warnings;
use base qw( Mojo::Base );
use Waffy::Util;
use Waffy::Config;
use Waffy::Data::Timeline;
use Waffy::Data::Period;
use Net::Twitter;
use UNIVERSAL::require;
use Carp;

sub create {
    my ( $class, $service_name ) = @_;
    unless ( $service_name ) {
        Carp::croak( 'No service specified as ' . __PACKAGE__ . '->create( service )' );
    }
    my $service_class = "Waffy::Service::" . ucfirst $service_name;
    $service_class->require or die $@;
    return $service_class->new();
}

sub new {
    my $class = shift;
    my $self = $class->SUPER::new;
    return $self;
}

sub service {
    my $self = shift;
    my $class = ref $self;
    my ( $service_name ) = $class =~ /::([^:]+)?$/;
    return lc $service_name;
}

sub interface {
    my $self = shift;
    my $config = Waffy::Config->new;
    my %args = ( map {
        $_ => $config->{ services }->{ $self->service }->{ $_ }
    } qw( username password apiurl apihost apirealm ) );
    return Net::Twitter->new( \%args );
}

sub friends_timeline { Carp::croak "friends_timeline() is ABSTRACT METHOD!" }

sub make_opts { return {} } # default

sub update {
    my ( $self, $args ) = @_;
    my $result = $self->interface->friends_timeline( $args );
    return $result;
}

sub replies {
    my ( $self, $args ) = @_;
    my $result = $self->interface->replies( $args );
    return $result;
}

sub crawl {
    my $self = shift;
    my $opts = $self->make_opts;
    my $timelines = $self->friends_timeline( $opts );
    for my $timeline ( @$timelines ) {
        # insertするまえに存在チェックしないとBus error...
        my $timeline_obj = Waffy::Data::Timeline->new( %$timeline );
        $timeline_obj->save;
    }
    Waffy::Data::Period->new(
        service         => $self->service,
        last_crawled_at => epoch2datetime(),
    )->save;
}

1;
