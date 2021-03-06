#!/usr/bin/env bash
set -e
set -o pipefail
set -u

mkdir -p webapps/turnin/WEB-INF/classes
scalac -version
scalac -deprecation -cp $(ls lib/*.jar webapps/turnin/WEB-INF/lib/*.jar | awk '{printf "%s:",$0}') \
    -d webapps/turnin/WEB-INF/classes \
    src/*.scala

echo >&2 "Copying libraries for current scala version..."
#SCALA=$(cd $(dirname $(which scala))/..; pwd)
SCALA="/usr/share/java/"
cp $SCALA/scala-library.jar $PWD/webapps/turnin/WEB-INF/lib/
cp $SCALA/scala-compiler.jar $PWD/webapps/turnin/WEB-INF/lib/
