	
FROM	ruby:alpine
LABEL	maintainer="eye@eyenx.ch"
COPY	docker-entrypoint.sh	/docker-entrypoint.sh
RUN	apk add --no-cache \
	task \
	fetchmail \
	&& gem install twmail \
	&& chmod +x /docker-entrypoint.sh \
	&& adduser -D tw \
	&& mkdir /home/tw/.task \
	&& chown tw:tw /home/tw -R
VOLUME	/home/tw/.task
USER	tw
ENTRYPOINT	["/docker-entrypoint.sh"]
