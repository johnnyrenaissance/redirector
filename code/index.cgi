#!/xampp/perl/bin/perl -wT
##
##  CGI Application
##
use CGI::Carp qw/fatalsToBrowser warningsToBrowser/;
use strict;
use lib qw(.);

use Redirector;
my $app = Redirector->new();
$app->run();

