#!/bin/sh

mkdir -p work
mkdir -p results
cd work

git clone --depth=1 git@github.com:reazen/relude.git 
cp -r relude relude_melange
mkdir -p ../results/relude

cd relude
npm install
npx bsb -make-world 2>> ../../results/relude/avant.stderr 1>> ../../results/relude/avant.stdout
echo $? > ../../results/relude/avant

cd ../relude_melange
cp ../../esy.json .
npm install
rm -rf node_modules/bs-platform
esy
esy bsb -make-world 2>> ../../results/relude/melange.stderr 1>> ../../results/relude/melange.stdout
echo $? > ../../results/relude/melange

# TODO: Run Reason v4 on all .re files and see if it trips. If it does might be helpful to run v3.6 to see if it also trips since if it does likely an actual bug in someone's code that we can ignore