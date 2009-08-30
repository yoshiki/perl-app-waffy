package Waffy::Example;

use strict;
use warnings;

use base 'Mojolicious::Controller';

# This action will render a template
sub welcome {
    my $self = shift;

    # Render template "example/welcome.html.epl" with message and layout
    $self->render(
        layout  => 'default',
        message => 'Welcome to the Mojolicious Web Framework!'
    );
}

1;
