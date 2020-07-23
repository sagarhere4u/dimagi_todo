#!/bin/bash

export TODO_SETTINGS=/home/todo/todo_local.cfg
export FLASK_APP=todo.py

cd /home/devops/todo
cv=`git ls-remote --heads https://github.com/dimagi/todo.git master | awk '{print $1}'`
cvc=`cat /home/devops/todo_with_shell/version | tail -1`

if [[ "$cv" == "$cvc" ]]
then
   echo "Application already up to date!"
else
   git ls-remote --heads https://github.com/dimagi/todo.git master | awk '{print $1}' >> /home/devops/todo_with_shell/version
   git fetch
   git checkout master
   git pull
   . env/bin/activate
   pip install -U -r requirements.txt
   flask db upgrade
   pkill -u devops flask
   flask run -h 0.0.0.0 > /dev/null & 
fi
