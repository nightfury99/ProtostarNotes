#!/bin/bash

if [ $# -eq 0 ]
then 
	echo "$0 <message to commit>"
	exit 1
fi

git pull
git add .
git commit -m $1
git push -u origin main
