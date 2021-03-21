#!/usr/bin/perl
use lib 'lib';
use strict;
use warnings;
use Mojo::Base -strict;

use Test::Mojo;
use Test::More;

use Gitprep;

my $gitprep_version = $Gitprep::VERSION;

subtest 'anonymous access' => sub {
    my $t = Test::Mojo->new('Gitprep');

    $t->get_ok('/')->status_is(200)->content_like(qr/Version $gitprep_version/);

    $t->ua->max_redirects(1);
    $t->get_ok('/_new')->status_is(200)->content_unlike(qr/Create a new repository/);

    $t->get_ok('/alpha6/private')->status_is(200)->content_like(qr/private is private repository/);

    $t->get_ok('/alpha6/public')->status_is(200)->content_like(qr/README.md/);

};

done_testing();
