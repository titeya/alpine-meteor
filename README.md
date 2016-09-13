Node 4.5

## Examples:

### pre-bundled on volume
```sh
docker run --rm \
  -e ROOT_URL=http://testsite.com \
  -e METEOR_SETTINGS={} \
  -e BUNDLE_APP=myapps.tar.gz \
  -e MONGO_URL=mongodb://mongoserver.com:27017/database \
  -e MONGO_OPLOG_URL=mongodb://mongoserver.com:27017/local \
  -v /usr/mapps:/usr/mapps
  titeya/alpine-meteor
```
