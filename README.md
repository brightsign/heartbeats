#README - heartbeats

##Overview
This repository holds an example of a simple presentation with a BrightAuthor Plugin and a PHP script that illustrates how to do 'heartbeats' from Brightsign players.

##Server-Side

You will need an Apache web server set up to run PHP scripts and a MySQL database.  This can be on any operating system of your choice (but we have only tested on Linux).  Place the PHP script into the web space of the server.  Edit it to have the user name and password for your database - look for the tags REPLACEUSERNAME and REPLACEPASSWORD.  We'll assume you know how to handle setting up MySQL so it's secure.

##BrightAuthor

The hearbeat-demo project shows a simple example of how to use the heartbeart plugin.  Add it as a plugin under Files->Presentation Properties->Autorun.  Then from a timer - or any action anywhere - you can 'Send' a plugin message.  Whatever message text you use will be inserted as the 'event' string that goes into the database.  DO NOT USE SPACES OR PUNCTUATION in that string - it can confuse things.  Use a string like "timeout" or "button press" or something.  This will allow you to have many different events trigger the 'heartbeat' and can track that in the database.

<nowiki>You will need to create a user variable called "heartbeat_url" and set it to the URL of the PHP script on your server.  You can also create a user variable called "heartbeat_tag" and put text there that you want to use to help make database queries.  </nowiki>

