
use warnings;
use strict;

package Log::Report::Optional;
use base 'Exporter';

=chapter NAME
Log::Report::Optional - Log::Report or ::Minimal

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
   {   $supported = 'Log::Report';
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