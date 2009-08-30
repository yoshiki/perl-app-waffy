package Waffy;

use strict;
use warnings;

use base 'Mojolicious';

# This method will run once at server start
sub startup {
    my $self = shift;

    # Routes
    my $r = $self->routes;

    # Default route
    $r->route('/:controller/:action/:id')
      ->to(controller => 'example', action => 'welcome', id => 1);
}

1;
