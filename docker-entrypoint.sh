#!/usr/bin/env sh

# This scripts workflow is the following:
# sync tasks from taskd server
# configure and run fetchmail with mda twmail
# sync tasks from taskd server

test -z $FETCHMAIL_SERVER && echo \$FETCHMAIL_SERVER is not set! && exit 1
test -z $FETCHMAIL_USER && echo \$FETCHMAIL_USER is not set! && exit 1
test -z $FETCHMAIL_PASSWORD && echo \$FETCHMAIL_PASSWORD is not set! && exit 1
test -x $INTERVAL && echo \$INTERVAL not set, defaulting to 300 seconds && INTERVAL=300

echo -e "poll \"$FETCHMAIL_SERVER\" proto imap port 993\nuser \"$FETCHMAIL_USER\" password \"$FETCHMAIL_PASSWORD\"\nssl\nmda twmail" > /home/tw/.fetchmailrc
chmod 0700 /home/tw/.fetchmailrc
while : ;
 do
   task sync
   fetchmail
   task sync
   sleep $INTERVAL
 done
