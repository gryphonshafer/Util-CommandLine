package Util::CommandLine;
# ABSTRACT: Command-line interface helper utility

use 5.008;
use strict;
use warnings;

use Getopt::Long 'GetOptions';
use Pod::Usage 'pod2usage';
use Proc::PID::File;
use Term::ReadKey 'ReadMode';

# VERSION

use constant EXPORT_OK => [ qw( options pod2usage singleton readmode ) ];

sub import {
    my $self = shift;

    # determine the caller and setup the exports hash
    my $callpkg = caller();
    my %exports = map { $_ => 1 } grep {
        my $x = $_;
        grep { $_ eq $x } @{(EXPORT_OK)};
    } @_;

    # method injection as appropriate
    {
        no strict 'refs';
        *{"$callpkg\::$_"} = \&{"$self\::$_"} for ( keys %exports );
    }

    singleton() if ( grep { $_ eq 'singleton' } @_ );
    options()   if ( grep { $_ eq 'podhelp'   } @_ );

    return;
}

sub singleton {
    my @dirs = (
        '/var/run',
        '/tmp',
        $ENV{HOME},
        '.',
        '/',
    );

    my $singleton;
    eval {
        if ( Proc::PID::File->running({ dir => shift @dirs }) ) {
            warn "Running as singleton; forcing exit of $0\n";
            exit 1;
        }
        $singleton = 1;
    } while ( not $singleton and @dirs );

    die "Unable to establish PID file for singleton functionality\n" unless ($singleton);

    return;
}

sub options {
    shift if ( index( ( $_[0] || '' ), '::' ) != -1 );

    my $settings = {};
    GetOptions( $settings, @_, qw( help man ) ) || pod2usage(0);

    pod2usage( '-exitstatus' => 1, '-verbose' => 1 ) if ( $settings->{'help'} );
    pod2usage( '-exitstatus' => 0, '-verbose' => 2 ) if ( $settings->{'man'}  );

    return $settings;
}

sub readmode {
    return ReadMode(@_);
}

1;
__END__
=pod

=begin :badges

=for markdown
[![Build Status](https://travis-ci.org/gryphonshafer/Util-CommandLine.svg)](https://travis-ci.org/gryphonshafer/Util-CommandLine)
[![Coverage Status](https://coveralls.io/repos/gryphonshafer/Util-CommandLine/badge.png)](https://coveralls.io/r/gryphonshafer/Util-CommandLine)

=end :badges

=head1 SYNOPSIS

    # example 1
    use Util::CommandLine qw( options pod2usage readmode );

    my $settings = options( qw( text=s alttext=s flag1 flag2 ) );
    pod2usage( '-exitstatus' => 1, '-verbose' => 1 ) if ( $settings->{'help'} );

    print 'Enter password: ';
    readmode 'noecho';
    my $password = <STDIN>;
    readmode 'restore';

    # example 2
    use Util::CommandLine qw( podhelp singleton );

=head1 DESCRIPTION

This library is command-line interface helper utility. It unifies some useful
sub-utilities for command-line programs.

=head1 EXAMPLES

=head2 options

This function if imported let's you make a simple call to leverage the awesome
of L<Getopt::Long> and L<Pod::Usage>.

    my $settings = options( qw( text=s alttext=s flag1 flag2 ) );
    print $settings->{'text'} if ( $settings->{'flag1'} );

The parameters passed into options() are the Getopt::Long inputs. The function
will return a hashref. During the process, the function will also setup support
for "help" and "man" flags using local POD for documentation. Thus, if you
pass in the "help" flag, the "SYNOPSIS" section of the local POD will display.
If you pass in the "man" flag, the whole of the local POD will display as a
man page.

=head2 podhelp

This flag is a simplified version of options() in that it'll automatically
setup support for "help" and "man" flags using local POD for documentation, but
it won't process any options.

=head2 pod2usage

This is pure export from L<Pod::Usage>.

    pod2usage( '-exitstatus' => 1, '-verbose' => 1 ) if ( $settings->{'help'} );

=head2 singleton

For some command-line programs (typically longer-running cron-triggered
programs), it's a good idea to ensure only a single instance of the program
runs at any given time. Use the "singleton" flag.

On startup, this will use L<Proc::PID::File> to check for any other instances of
the program running. If they are running, the program will die with an
appropriate error.

=head2 readmode

This is the same function as L<Term::ReadKey>'s C<ReadMode>.

=head1 DEPENDENCIES

This module has the following dependencies:
L<Getopt::Long>, L<Pod::Usage>, L<Proc::PID::File>, L<Term::ReadKey>.

=head1 SEE ALSO

You can look for additional information at:

=for :list
* L<GitHub|https://github.com/gryphonshafer/Util-CommandLine>
* L<MetaCPAN|https://metacpan.org/pod/Util::CommandLine>
* L<Travis CI|https://travis-ci.org/gryphonshafer/Util-CommandLine>
* L<Coveralls|https://coveralls.io/r/gryphonshafer/Util-CommandLine>
* L<CPANTS|http://cpants.cpanauthors.org/dist/Util-CommandLine>
* L<CPAN Testers|http://www.cpantesters.org/distro/U/Util-CommandLine.html>

=cut
