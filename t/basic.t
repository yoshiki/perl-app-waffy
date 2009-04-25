#!perl

use strict;
use warnings;

use Mojo::Client;
use Mojo::Transaction;
use Test::More tests => 4;

use_ok('Waffy');

# Prepare client and transaction
my $client = Mojo::Client->new;
my $tx     = Mojo::Transaction->new_get('/');

# Process request
$client->process_local('Waffy', $tx);

# Test response
is($tx->res->code, 200);
is($tx->res->headers->content_type, 'text/html');
like($tx->res->content->file->slurp, qr/Mojolicious Web Framework/i);
