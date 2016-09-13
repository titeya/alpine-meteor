#!/bin/bash
set -e

# Default values
: ${APP_DIR:="/var/www"}      # Location of built Meteor app
: ${SRC_DIR:="/src/app"}      # Location of Meteor app source
: ${BRANCH:="master"}
: ${MONGO_URL:="mongodb://${MONGO_PORT_27017_TCP_ADDR}:${MONGO_PORT_27017_TCP_PORT}/${DB}"}
: ${PORT:="80"}
: ${RELEASE:="latest"}

export MONGO_URL
export PORT

# If we were given arguments, run them instead
if [ $? -gt 1 ]; then
   exec "$@"
fi

# Make sure critical directories exist
mkdir -p $APP_DIR
mkdir -p $SRC_DIR

# If we were given a BUNDLE_URL, download the bundle
# from there.
if [ -n "${BUNDLE_APP}" ]; then
   tar -zxvf /var/mapps/${BUNDLE_APP} -C ${APP_DIR}
fi

# Locate the actual bundle directory
# subdirectory (default)
if [ ! -e ${BUNDLE_DIR:=$(find ${APP_DIR} -type d -name bundle -print |head -n1)} ]; then
   # No bundle inside app_dir; let's hope app_dir _is_ bundle_dir...
   BUNDLE_DIR=${APP_DIR}
fi

# Install NPM modules
if [ -e ${BUNDLE_DIR}/programs/server ]; then
   echo "Installing NPM prerequisites..."
   pushd ${BUNDLE_DIR}/programs/server/

   # Use a version of fibers which has a binary
   mv npm-shrinkwrap.json old-shrinkwrap.json
   cat old-shrinkwrap.json |jq -r 'setpath(["dependencies","fibers","resolved"]; "https://registry.npmjs.org/fibers/-/fibers-1.0.7.tgz")' > npm-shrinkwrap.json

   # Install all NPM packages
   npm install
   popd
else
   echo "Unable to locate server directory in ${BUNDLE_DIR}; hold on: we're likely to fail"
fi

if [ ! -e ${BUNDLE_DIR}/main.js ]; then
   echo "Failed to locate main.js in ${BUNDLE_DIR}; cannot start application."
   exit 1
fi

# Run meteor
cd ${BUNDLE_DIR}
echo "Starting Meteor Application..."
exec node ./main.js
