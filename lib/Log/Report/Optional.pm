# This code is part of distribution Log-Report-Optional. Meta-POD processed
# with OODoc into POD and HTML manual-pages.  See README.md
# Copyright Mark Overmeer.  Licensed under the same terms as Perl itself.

package Log::Report::Optional;
use base 'Exporter';

use warnings;
use strict;

=chapter NAME
Log::Report::Optional - pick Log::Report or ::Minimal

=chapter SYNOPSIS
 # Use Log::Report when already loaded, otherwise Log::Report::Minimal
 package My::Package;
 use Log::Report::Optional 'my-domain';

=chapter DESCRIPTION 
This module will allow libraries (helper modules) to have a dependency
to a small module instead of the full Log-Report distribution.  The full
power of C<Log::Report> is only released when the main program uses that
module.  In that case, the module using the 'Optional' will also use the
full M<Log::Report>, otherwise the dressed-down M<Log::Report::Minimal>
version.

For the full documentation:

=over 4

=item * see M<Log::Report> when it is used by main

=item * see M<Log::Report::Minimal> otherwise

=back

The latter provides the same functions from the former, but is the
simpelest possible way.

=cut

my ($supported, @used_by);

BEGIN {
   if($INC{'Log/Report.pm'})
   {   $supported  = 'Log::Report';
       my $version = $Log::Report::VERSION;
       die "Log::Report too old for ::Optional, need at least 1.00"
           if $version && $version le '1.00';
   }
   else
   {   require Log::Report::Minimal;
       $supported = 'Log::Report::Minimal';
   }
}

sub import(@)
{   my $class = shift;
    push @used_by, (caller)[0];
    $supported->import('+1', @_);
}

=chapter METHODS

=c_method usedBy

Returns the classes which loaded the optional module.

=cut

sub usedBy() { @used_by }

1;
