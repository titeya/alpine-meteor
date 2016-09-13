
FROM mhart/alpine-node:4

RUN apk add --update bash jq python make g++ && rm -rf /var/cache/apk/*

# Make sure we have a directory for the application
RUN mkdir -p /var/www && \
   ln -s /usr/bin/nodejs /usr/bin/node

# Install Meteor -- now done on-demand to reduce image size
# If you supply your pre-bundled app, you do not need the
# Meteor tool.
#RUN curl https://install.meteor.com/ |sh

# Install entrypoint
ADD entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD []
