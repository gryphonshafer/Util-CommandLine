# NAME

Util::CommandLine - Command-line interface helper utility

# VERSION

version 1.09

[![test](https://github.com/gryphonshafer/Util-CommandLine/workflows/test/badge.svg)](https://github.com/gryphonshafer/Util-CommandLine/actions?query=workflow%3Atest)
[![codecov](https://codecov.io/gh/gryphonshafer/Util-CommandLine/graph/badge.svg)](https://codecov.io/gh/gryphonshafer/Util-CommandLine)

# SYNOPSIS

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

    # example 3
    my $opt = options('set|s=s{0,3} extra|e=s');

# DESCRIPTION

This library is command-line interface helper utility. It unifies some useful
sub-utilities for command-line programs.

# EXAMPLES

## options

This function if imported let's you make a simple call to leverage the awesome
of [Getopt::Long](https://metacpan.org/pod/Getopt%3A%3ALong) and [Pod::Usage](https://metacpan.org/pod/Pod%3A%3AUsage).

    my $settings = options( qw( text=s alttext=s flag1 flag2 ) );
    print $settings->{'text'} if ( $settings->{'flag1'} );

The parameters passed into options() are the Getopt::Long inputs. The function
will return a hashref. During the process, the function will also setup support
for "help" and "man" flags using local POD for documentation. Thus, if you
pass in the "help" flag, the "SYNOPSIS" section of the local POD will display.
If you pass in the "man" flag, the whole of the local POD will display as a
man page.

## podhelp

This flag is a simplified version of options() in that it'll automatically
setup support for "help" and "man" flags using local POD for documentation, but
it won't process any options.

## pod2usage

This is pure export from [Pod::Usage](https://metacpan.org/pod/Pod%3A%3AUsage).

    pod2usage( '-exitstatus' => 1, '-verbose' => 1 ) if ( $settings->{'help'} );

## singleton

For some command-line programs (typically longer-running cron-triggered
programs), it's a good idea to ensure only a single instance of the program
runs at any given time. Use the "singleton" flag.

On startup, this will use [Proc::PID::File](https://metacpan.org/pod/Proc%3A%3APID%3A%3AFile) to check for any other instances of
the program running. If they are running, the program will die with an
appropriate error.

## readmode

This is the same function as [Term::ReadKey](https://metacpan.org/pod/Term%3A%3AReadKey)'s `ReadMode`.

# DEPENDENCIES

This module has the following dependencies:
[Getopt::Long](https://metacpan.org/pod/Getopt%3A%3ALong), [Pod::Usage](https://metacpan.org/pod/Pod%3A%3AUsage), [Proc::PID::File](https://metacpan.org/pod/Proc%3A%3APID%3A%3AFile), [Term::ReadKey](https://metacpan.org/pod/Term%3A%3AReadKey).

# SEE ALSO

You can look for additional information at:

- [GitHub](https://github.com/gryphonshafer/Util-CommandLine)
- [MetaCPAN](https://metacpan.org/pod/Util::CommandLine)
- [GitHub Actions](https://github.com/gryphonshafer/Util-CommandLine/actions)
- [Codecov](https://codecov.io/gh/gryphonshafer/Util-CommandLine)
- [CPANTS](http://cpants.cpanauthors.org/dist/Util-CommandLine)
- [CPAN Testers](http://www.cpantesters.org/distro/U/Util-CommandLine.html)

# AUTHOR

Gryphon Shafer <gryphon@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2015-2050 by Gryphon Shafer.

This is free software, licensed under:

    The Artistic License 2.0 (GPL Compatible)
