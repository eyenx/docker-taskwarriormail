# TaskWarriorMail as a Docker Container


![](https://github.com/eyenx/docker-taskwarriormail/workflows/build%20image/badge.svg)

This container includes:

* fetchmail to fetch mails
* taskwarrior using a predefined taskrc
* [TaskWarriorMail](https://github.com/nerab/TaskWarriorMail/) to get mails and add it to your tasks

**This workflow only works if it can sync with a taskd server**

## Environment Variables

```
FETCHMAIL_USER=user@example.org
FETCHMAIL_PASSWORD=thisisasecret!
FETCHMAIL_SERVER=mail.example.org
INTERVAL=300 #interval in seconds before fetching mail again
```

## Mail Settings

SSL is enforced by default in fetchmail.rc:

```
poll $FETCHMAIL_SERVER proto imap port 993
user $FETCHMAIL_USER password $FETCHMAIL_PASSWORD
ssl
mda twmail
```

## Volumes used

* `/home/tw/.task` for data
* `/home/tw/.taskrc` for configuration (this is a file)

## Example taskrc

```
data.location=~/.task

taskd.server=task.example.org:1337
taskd.credentials=default/user/my-secret-uuid
taskd.certificate=~/.task/user.cert.pem
taskd.key=~/.task/user.key.pem
taskd.trust=ignore hostname
taskd.ca=~/.task/ca.cert.pem
```


## Workflow

* sync tasks
* use TaskWarriorMail to fetch mail and add task
* sync task
* sleep `$INTERVAL`

## Example usage:

```
docker run -e FETCHMAIL_SERVER=mail.example.org -e FETCHMAIL_USER=taskwarrior@example.org -e FETCHMAIL_PASSWORD=mysecretpassword! -v $(pwd)/.task:/home/tw/.task -v $(pwd)/.taskrc:/home/tw/.taskrc ghcr.io/eyenx/taskwarriormail
$INTERVAL not set, defaulting to 300 seconds
Syncing with taskwarrior.example.org:1337
Sync successful.  No changes.
1 message for taskwarrior@example.org at mail.
Additional text must be provided.
reading message taskwarrior@example.org@mail.example.org:1 of 1 (4132 header octets) (0 body octets) flushed
Syncing with taskwarrior.example.org:1337
Sync successful.  1 changes uploaded.
```
