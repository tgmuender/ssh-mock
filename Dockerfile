FROM sickp/alpine-sshd:latest

ADD entrypoint.sh /opt/

ENTRYPOINT ["/opt/entrypoint.sh"]
