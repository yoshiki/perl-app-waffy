package Waffy;

use strict;
use warnings;

use base 'Mojolicious';
use MojoX::Renderer::TT;
use Waffy::Util ();

# This method will run for each request
sub dispatch {
    my ($self, $c) = @_;

    # Try to find a static file
    my $done = $self->static->dispatch($c);

    # Use routes if we don't have a response code yet
    $done ||= $self->routes->dispatch($c);

    # Nothing found, serve static file "public/404.html"
    $self->static->serve_404($c) unless $done;
}

# This method will run once at server start
sub startup {
    my $self = shift;

    # Use our own context class
    $self->ctx_class('Waffy::Context');

    # Routes
    my $r = $self->routes;

    # Default route
    $r->route('/:controller/:action')
      ->to(controller => 'root', action => 'index');

    # use TT
    my $tt = MojoX::Renderer::TT->build(
        mojo             => $self,
        template_options => {
            INCLUDE_PATH => [ Waffy::Util::path_to( 'templates/includes' ) ],
        },
    );
    $self->renderer->add_handler( tt => $tt );
    $self->renderer->default_format( 'tt' );
    $self->renderer->types->type( tt => 'text/html;charset=utf8' );
}

1;
