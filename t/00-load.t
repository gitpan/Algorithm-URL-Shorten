#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Algorithm::URL::Shorten' ) || print "Bail out!
";
}

diag( "Testing Algorithm::URL::Shorten $Algorithm::URL::Shorten::VERSION, Perl $], $^X" );
