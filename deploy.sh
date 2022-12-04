#!/bin/bash
echo "started deployment preparation of backstage"
echo "using node version: $(node --version)"
echo "using yarn version: v$(yarn --version)"

# yarn install
# yarn tsc
# yarn build:backend

directory="src/main/docker/app"

if [ -d $directory ]
  then
    echo "$directory exists already -> deleting directory"
    rm -rf $directory
    # ggf. ordner löschen
fi

mkdir -p "$(pwd)/$directory" && echo "\"$directory created\""

if [ ! -d $directory ]
  then
    exit
fi

echo "copy skeleton.tar.gz yarn.lock package.json to $directory"
cp packages/backend/dist/skeleton.tar.gz yarn.lock package.json $directory/
echo "extracting skeleton.tar.gz and removing archive"
tar xzf $directory/skeleton.tar.gz -C $directory && rm $directory/skeleton.tar.gz

(cd $directory && yarn install --frozen-lockfile --production --network-timeout 300000)

echo "copy bundle.tar.gz app-config.yaml to $directory"
cp packages/backend/dist/bundle.tar.gz app-config.yaml $directory/
echo "extracting bundle.tar.gz and removing archive"
tar xzf $directory/bundle.tar.gz -C $directory && rm $directory/bundle.tar.gz

echo "finished deployment preparation of backstage"

exit
