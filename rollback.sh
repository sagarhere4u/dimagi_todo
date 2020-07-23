#!/bin/bash

export TODO_SETTINGS=/home/todo/todo_local.cfg
export FLASK_APP=todo.py

cd /home/devops/todo
var="$1"
cv=`cat /home/devops/todo_with_shell/version | tail -"$var" | head -1`
echo $cv
git reset --hard $cv
echo "$cv" >> /home/devops/todo_with_shell/version
#git pull
. env/bin/activate
pip install -U -r requirements.txt
flask db upgrade
pkill -u devops flask
flask run -h 0.0.0.0 > /dev/null & 
