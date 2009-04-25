package Waffy::Example;

use strict;
use warnings;

use base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
    my $self = shift;

    # Render template "example/welcome.phtml"
    $self->render;
}

1;
