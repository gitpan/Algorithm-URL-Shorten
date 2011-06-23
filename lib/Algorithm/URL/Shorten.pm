package Algorithm::URL::Shorten;
BEGIN {
  $Algorithm::URL::Shorten::VERSION = '0.05';
}

use base Exporter;
use Digest::MD5 qw(md5_hex);

use strict;
use warnings;

=head1 NAME

Algorithm::URL::Shorten - URL shortening algorithm.

=head1 VERSION

version 0.05

=head1 SYNOPSIS

Algorithm::URL::Shorten generates short codes used to map and represent
longer URLs.

    use Algorithm::URL::Shorten qw(shorten_url);

    my $shorts = shorten_url("http://perl.org");

    foreach $code (@{$shorts}) {
        print $code, "\n";
    }

This code prints

    iqGzim
    S515va
    qmKrq8
    HXv4HD

=head1 DESCRIPTION

The codes generated with Algorithm::URL::Shorten are unique for every URL,
so that every time it is used on the same URL, it will generate the same
codes.

The short strings are alphanumeric ASCII ([a-z], [A-Z], and [0-9]) for a
total of 62 characters, which may be mapped in 62 ^ 6.

=head1 EXPORT

The module exports the subroutine 'shorten_url' on request.

=cut

our @EXPORT_OK = qw(shorten_url);

=head1 SUBROUTINES

=head2 shorten_url( $url )

This function takes as arguments an URL to shorten, and the desired lenght
of the shortened values, and returns an array reference containing 4 values.

The generated codes will be of six characters long.

=cut

sub shorten_url {
	my $url= shift;

	my @chars = ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
		     'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
		     'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
		     'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F',
		     'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
		     'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
		     'W', 'X', 'Y', 'Z', '0', '1', '2', '3',
		     '4', '5', '6', '7', '8', '9');

	my @output;
	my $hex = md5_hex($url);

	for (my $i = 0; $i < length($hex) / 8; $i++) {
		my $sub_hex = "0x".substr $hex, $i * 8, 8;
		my $int     = hex $sub_hex;
		my $out;

		for (my $j = 0; $j < 6; $j++) {
			my $val = 0x0000003D & $int;
			$out   .= $chars[$val];
			$int    = $int >> 5;
		}

		push @output, $out;
	}

	return \@output;
}


=head1 ACKNOWLEDGMENTS

From version 0.03 the algorithm for generating short codes has slightly
changed due to some bugs in the code. The codes generated by the algorithm
v0.02 and v0.01 are not compatible with the new version.

=head1 AUTHOR

Alessandro Ghedini <alexbio@cpan.org>

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of Algorithm::URL::Shorten