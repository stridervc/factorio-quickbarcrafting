#!/bin/bash
VERSION=`grep version info.json | grep -v factorio | cut -d ':' -f 2 | sed 's/\"//g' | sed 's/^\s*//' | sed 's/,$//'`
NAME="QuickBarCrafting_$VERSION"
ZIPFILE="${NAME}.zip"

rm -f /tmp/$ZIPFILE
rm -rf /tmp/$NAME

mkdir /tmp/$NAME
cp -r *lua *json locale LICENSE changelog.txt /tmp/$NAME/

pushd /tmp
zip -r $ZIPFILE $NAME
popd
mv /tmp/$ZIPFILE .
