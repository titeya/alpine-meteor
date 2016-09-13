## Meteor 1.4

The `latest` Docker tag refers to `legacy` right now, which means it will not
work with Meteor version 1.4+

If you wish to use a Meteor application 1.4+, you will need to use the `v1.4` Docker tag.

If you wish to continue using versions of Meteor before 1.4, please switch to
using the `legacy` tag.

The `latest` Docker tag will switch to Meteor 1.4 soon.


## Examples:

### pre-bundled git repo
```sh
docker run --rm \
  -e ROOT_URL=http://testsite.com \
  -e BUNDLE_URL=https://github.com/yourName/testsite/apps.tar.gz \
  -e MONGO_URL=mongodb://mymongoserver.com:27017/mydatabase \
  -e MONGO_OPLOG_URL=mongodb://mymongoserver.com:27017/local \
  titeya/dockermeteor
```
