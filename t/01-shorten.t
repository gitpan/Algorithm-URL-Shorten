#!perl -T

use Algorithm::URL::Shorten qw(shorten_url);

use Test::More tests => 4;

my $shorts = shorten_url("http://perl.org");

is(@{$shorts}[0], "zKH5bO");
is(@{$shorts}[1], "eqSbWf");
is(@{$shorts}[2], "ymaay0");
is(@{$shorts}[3], "8rqWn0");
