package Algorithm::URL::Shorten;

use base Exporter;
use Digest::MD5 qw(md5_hex);

use strict;
use warnings;

=head1 NAME

Algorithm::URL::Shorten - URL shortening algorithm.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

Algorithm::URL::Shorten generates short codes used to map and represent
longer URLs.

    use Algorithm::URL::Shorten qw(shorten_url);

    my $shorts = shorten_url("http://perl.org", 6);

    foreach $code (@{$shorts}) {
        print $code, "\n";
    }

This code prints

    isazkm
    mBvzxc
    soerqC
    dtvydF

=head1 DESCRIPTION

The codes generated with Algorithm::URL::Shorten are unique for every URL,
so that every time it is used on the same URL, it will generate the same
codes.

The short strings are alphanumeric ASCII ([a-z], [A-Z], and [0-9]) for a
total of 62 characters, which may be mapped in, depending on the lenght,
62 ^ n codes (where n is the actual size of the strings generated).

=head1 EXPORT

The module exports the subroutine 'shorten_url' on request.

=cut

our @EXPORT_OK = qw(shorten_url);

=head1 SUBROUTINES/METHODS

=head2 shorten_url( $url, $short_lenght)

This function takes as arguments an URL to shorten, and the desired lenght
of the shortened values, and returns an array reference containing 4 values.

The $short_lenght may be set to numbers <= 7, due to the fixed lenght of
an md5 hash, which is used by the algorithm.

=cut

sub shorten_url {
	my ($url, $short_lenght) = @_;
	$short_lenght = $short_lenght <= 7 ? $short_lenght : 7;
	

	my @chars = ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h',
		     'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
		     'q', 'r', 's', 't', 'u', 'v', 'w', 'x',
		     'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F',
		     'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
		     'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
		     'W', 'X', 'Y', 'Z', '0', '1', '2', '3',
		     '4', '5', '6', '7', '8', '9');

	my @output;
	my $hex = md5_hex(shift);

	for (my $i = 0; $i < length($hex) / 8; $i++) {
		my $sub_hex = "0x".substr $hex, $i * 8, 8;
		my $int     = hex $sub_hex;
		my $out;

		for (my $j = 0; $j < $short_lenght; $j++) {
			my $val = 0x0000001F & $int;
			$out   .= $chars[$val];
			$int    = $int >> 5;
		}

		push @output, $out;
	}

	return \@output;
}

=head1 AUTHOR

Alessandro Ghedini, C<< <alexbio at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-algorithm-url-shorten at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Algorithm-URL-Shorten>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Algorithm::URL::Shorten

You can also look for information at:

=over 4

=item * GitHub

L<http://github.com/AlexBio/Algorithm-URL-Shorten>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Algorithm-URL-Shorten>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Algorithm-URL-Shorten>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Algorithm-URL-Shorten>

=item * Search CPAN

L<http://search.cpan.org/dist/Algorithm-URL-Shorten/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1; # End of Algorithm::URL::Shorten
