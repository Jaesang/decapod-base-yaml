#!/bin/bash
DECAPOD_BASE_URL=https://github.com/openinfradev/decapod-yaml.git
BRANCH="master"

if [ $# -eq 0 ]; then
  echo 'Error: Missing Arguments "application name"'
  exit 1
fi
APP_NAME=$1

if [ $# -eq 2 ]; then
  BRANCH=$2
fi

echo "Fetch decapod-base with $BRANCH branch/tag........"
git clone -b $BRANCH $DECAPOD_BASE_URL
if [ $? -ne 0 ]; then
  exit $?
fi

echo "Start to build for $APP_NAME"

for i in `ls ${APP_NAME}/site`
do
  ls -al $APP_NAME/output/$i/$APP_NAME-manifest.yaml
  rm -f $APP_NAME/output/$i/$APP_NAME-manifest.yaml
  mkdir -p $APP_NAME/output/$i/
  docker rm -f kustomize-build-$APP_NAME
  docker run -it -v $(pwd)/$APP_NAME:/decapod-yaml --name kustomize-build-$APP_NAME sktdev/decapod-kustomize:alpha-v2.0 /decapod-yaml/site/$i -o /decapod-yaml/output/$i/$APP_NAME-manifest.yaml;
  ls -al $APP_NAME/output/$i/$APP_NAME-manifest.yaml
done

rm -rf decapod-yaml
