package Waffy::Config;

use strict;
use warnings;
use YAML::Syck ();
use Path::Class;
use Mojo::Script;
use Data::Visitor::Callback;
use Waffy::Util;

sub new {
    my ( $class, $name, $file ) = @_;
    $name ||= ( $ENV{ WAFFY_CONFIG_NAME } || 'development' );
    $file ||= path_to( 'waffy.yml' );
    my $config = YAML::Syck::LoadFile( $file );
    my %config = (
        %{ $config->{ common } },
        %{ $config->{ $name } },
    );
    my $v = Data::Visitor::Callback->new(
        plain_value => sub {
            return unless defined $_;
            s{__HOME__}{Waffy::Util::home()}e;
            s{__path_to\(['\"]?(.+?)['\"]?\)__}{Waffy::Util::path_to( split( '/', $1 ) )}e;
        }
    );
    $v->visit(\%config);
    return bless \%config, $class;
}

1;
