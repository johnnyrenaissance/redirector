package Redirector;
use base 'CGI::Application';
use Sanitize;

use CGI::Application::Plugin::DBH (qw/dbh_config dbh/);
use CGI::Application::Plugin::Redirect;

my $default_url = "http://www.google.com";

sub setup {
    my $self = shift;
    $self->start_mode('redirect');
    $self->mode_param('mode');
    $self->run_modes(
        'redirect' => 'redirect'
    );

	my $config = get_config( './config/', 'config.ini' );
    $self->dbh_config('DBI:mysql:database=' . $config->{'database'} . ';host=' . $config->{'host'}, $config->{'username'}, $config->{'password'});
}

sub redirect {
    my $self = shift;

    my $q = $self->query();
    my $code = $q->param("code");

    unless ($code) {
        $self->header_add( -location => $default_url );
        return;
    }

    $code = sanitize($code, alpha => 1);
    my $sth = $self->dbh->prepare("select link, hits from links where code=?");
    $sth->execute($code);
    my @rows = $sth->fetchrow_array;

    if (scalar @rows) {
        my $link = $rows[0];
        $sth = $self->dbh->prepare("update links set hits = ? where code=?");
        $sth->bind_param(1, $rows[1]+1);
        $sth->bind_param(2, $code);
        $sth->execute();
        $self->header_add( -location => $link );
        return;
    }
    else {
        $self->header_add( -location => $default_url );
        return;
    }
}

sub teardown {
    my $self = shift;
    $self->dbh->disconnect;
}

sub get_config {
    my $path = shift;
	my $file = shift;
    $file = "$path$file";


    my %config;
    open(*CFILE, "<$file")	|| return "ERROR reading config file $file <br>\n$!";
    while(<CFILE>){
		my $line = $_;
		$line =~ m/(.*?)=(.*)/;
		my ($p, $v) = ($1, $2);
		$p =~ s/^\s*|\s*$|\n*//g;
		$v =~ s/^\s*|\s*$|\n*//g;
		$config{$p} = $v;
    }
    close CFILE;
    return \%config;
}

1;