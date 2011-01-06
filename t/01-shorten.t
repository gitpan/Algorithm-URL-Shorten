#!perl -T

use Algorithm::URL::Shorten qw(shorten_url);

use Test::More tests => 4;

my $shorts = shorten_url("http://perl.org");

is(@{$shorts}[0], "iqGzim");
is(@{$shorts}[1], "S515va");
is(@{$shorts}[2], "qmKrq8");
is(@{$shorts}[3], "HXv4HD");
