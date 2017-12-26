# NAME

Util::CommandLine - Command-line interface helper utility

# VERSION

version 1.04

[![Build Status](https://travis-ci.org/gryphonshafer/Util-CommandLine.svg)](https://travis-ci.org/gryphonshafer/Util-CommandLine)
[![Coverage Status](https://coveralls.io/repos/gryphonshafer/Util-CommandLine/badge.png)](https://coveralls.io/r/gryphonshafer/Util-CommandLine)

# SYNOPSIS

    use Util::CommandLine qw( options pod2usage );

    my $settings = options( qw( text=s alttext=s flag1 flag2 ) );
    pod2usage( '-exitstatus' => 1, '-verbose' => 1 ) if ( $settings->{'help'} );

# DESCRIPTION

This library is command-line interface helper utility. It unifies some useful
sub-utilities for command-line programs.

# EXAMPLES

## options

This function if imported let's you make a simple call to leverage the awesome
of [Getopt::Long](https://metacpan.org/pod/Getopt::Long) and [Pod::Usage](https://metacpan.org/pod/Pod::Usage).

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

This is pure export from [Pod::Usage](https://metacpan.org/pod/Pod::Usage).

    pod2usage( '-exitstatus' => 1, '-verbose' => 1 ) if ( $settings->{'help'} );

## singleton

For some command-line programs (typically longer-running cron-triggered
programs), it's a good idea to ensure only a single instance of the program
runs at any given time. Use the "singleton" flag.

On startup, this will use [Proc::PID::File](https://metacpan.org/pod/Proc::PID::File) to check for any other instances of
the program running. If they are running, the program will die with an
appropriate error.

# DEPENDENCIES

This module has the following dependencies: [Getopt::Long](https://metacpan.org/pod/Getopt::Long), [Pod::Usage](https://metacpan.org/pod/Pod::Usage), [Proc::PID::File](https://metacpan.org/pod/Proc::PID::File).

# SEE ALSO

You can look for additional information at:

- [GitHub](https://github.com/gryphonshafer/Util-CommandLine)
- [CPAN](http://search.cpan.org/dist/Util-CommandLine)
- [MetaCPAN](https://metacpan.org/pod/Util::CommandLine)
- [AnnoCPAN](http://annocpan.org/dist/Util-CommandLine)
- [Travis CI](https://travis-ci.org/gryphonshafer/Util-CommandLine)
- [Coveralls](https://coveralls.io/r/gryphonshafer/Util-CommandLine)
- [CPANTS](http://cpants.cpanauthors.org/dist/Util-CommandLine)
- [CPAN Testers](http://www.cpantesters.org/distro/U/Util-CommandLine.html)

# AUTHOR

Gryphon Shafer <gryphon@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Gryphon Shafer.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
