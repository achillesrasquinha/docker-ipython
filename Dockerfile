FROM python:alpine

WORKDIR /app

RUN set -o errexit -o nounset \
	&& echo "Installing dependencies" \
	&& apk add --no-cache \
		bash \
	&& echo "Adding user and group" \
	&& addgroup -S ipython \
	&& adduser -S -G ipython ipython 

RUN pip install ipython

COPY ./entrypoint /entrypoint
RUN sed -i 's/\r//' /entrypoint \
	&& chmod +x /entrypoint \
	&& chown ipython /entrypoint

COPY ./start /start
RUN sed -i 's/\r//' /start \
	&& chmod +x /start \
	&& chown ipython /start

ENTRYPOINT ["/entrypoint"]
CMD ["/start"]