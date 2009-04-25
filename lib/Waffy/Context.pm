package Waffy::Context;

use strict;
use warnings;
use base 'Mojolicious::Context';

use Waffy::Util;

sub handle_user_agent {
    my ( $self, $user_agent ) = @_;
    if ( is_iphone( $user_agent ) ) {
        return 'iphone';
    }
    elsif ( is_mobile_jp( $user_agent ) ) {
        return 'mobile_jp';
    }
}

1;
