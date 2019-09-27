#!/bin/bash
echo "checking if it's the first run..."
FILE=/data/teamcity_server/datadir/system/buildserver.properties
if test -f "$FILE"; then
    echo "$FILE exist no setup require...server will start as normal"
else
    aws s3 sync  s3://teamcity-server/ /data/teamcity_server/datadir --delete
fi
echo '/run-services.sh'

for entry in /services/*.sh
do
  if [[ -f "$entry" ]]; then
    echo "$entry"
    [[ ! -x "$entry" ]] && (chmod +x "$entry"; sync)
    "$entry"
  fi
done

echo '/run-server.sh'
exec '/run-server.sh'
