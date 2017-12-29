# Redirector

# #############################
#
# Written by Johnny Renaissance
#
# ############################# 


############
# WHAT
############

A super small perl program to redirect users based on the url path value. 

It's written on the CGI::Application framework (which is probably overkill, but I could spin up everything I needed in minutes).


############
# Depends on
############

This requires read/write access to a mysql database as well as the following Perl libraries

CGI::Carp
CGI::Application
CGI::Application::Plugin::DBH
CGI::Application::Plugin::Redirect
Sanitize


############
# Setup
############

1) Install the app in a web server directory. 
2) Install the dependencies. 
3) Update the config file with your mysql database values. 
4) Update the Redirector.pm with the proper path to your config file.
5) Create the table describe in links.sql

Profit!!!

Access the redirector with index.cgi?code=<yourlinkcodehere>

Which is nothing new or terribly exciting, especially since the default will forward you to google.

The reason I did this is so I could write an htaccess directive to allow me to say something like http://www.example.com/goto/books, and it will rewrite that to http://www.example.com/index.cgi?code=books, which will then redirect the user to an Amazon search which shows all the books I've authored.  To create a new link, it's simply a matter of adding a new code / link pair record in the database. I typically create things on the fly when I'm away from my computer and this allows me to connect to mysql with my phone (via a mysql manager app), add a record, and be able to hand off a link to someone. While other sites like bitly can do this much easier than I can, my point was to do some branding, so all links are through my domain. And I timed it. I can actually add a link to my system faster than I can add one to bitly.

There is a sample htaccess file included that I have used. I dropped it into my /goto directory (rename to .htaccess) and updated the domain name inside.


############
# SQL Setup
############

See the links.sql file for table creation.

To create a new link, do a command akin to: insert into links set code="ducky", link="https://duckduckgo.com/"


############
# Bonus
############

I threw in an UBER simple click tracker.  One redirect = 1 tracked hit. So if a person on a single system hits your redirect 1000 times, the hit count will be 1000. There is no session or origination IP logic to prevent multiple hits. But it's there.


############
# Caveat
############

This is not production code. There are much better solutions out there for redirection. I made this as a personal tool that gives me the exact type of access that I want with the exact amount of configurability as well as the ability to drop in the code and run it on any flavor of server.


############
# Perl Style
############

Don't judge me. It's 2am, I am working 2 contracts, and I needed to do something that wasn't "work" for a few minutes. There is absolutely no style in this program, except for the coffee stained font I used in developing it. I pulled pieces from programs I wrote almost 2 decades ago and whipped this up in the matter of minutes. All function. Zero form.


############
# Contact
############

This is on github, so I'm assuming they give you some way to contact me. Feel free to do that.