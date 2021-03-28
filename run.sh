#!/bin/sh

mkdir -p work
mkdir -p results
cd work

git clone --depth=1 git@github.com:pupilfirst/pupilfirst.git
cp -r pupilfirst pupilfirst_melange
mkdir -p ../results/pupilfirst

cd pupilfirst
npm install
npx bsb -make-world 2>> ../../results/pupilfirst/avant.stderr 1>> ../../results/pupilfirst/avant.stdout
echo $? > ../../results/pupilfirst/avant

cd ../pupilfirst_melange
cp ../../esy.json .
npm install
rm -rf node_modules/bs-platform
esy
esy bsb -make-world 2>> ../../results/pupilfirst/melange.stderr 1>> ../../results/pupilfirst/melange.stdout
echo $? > ../../results/pupilfirst/melange

# TODO: Run Reason v4 on all .re files and see if it trips. If it does might be helpful to run v3.6 to see if it also trips since if it does likely an actual bug in someone's code that we can ignore