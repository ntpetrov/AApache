#!/bin/bash

myspwd=`cat /root/.pmy`
echo "Enter database name: "
read db
echo ""
echo "Enter username for $db: "
read user
#db=$1
#user=$2
host=MYSQL_SERVER
if [ -z "$db" ] || [ -z "$user" ]; then

#	echo ""
#	echo "--------------------------------"
#	echo "-        USAGE:                -"
#	echo "-                              -"
#	echo "- $0 db user -"
#	#echo "-                             -"
#	echo "-                              -"
#	echo "--------------------------------"
	echo "Incorrect data....Exiting...."
exit 1

fi

echo -n "Enter password for $user: "
read -s pass

if [ -z "$pass" ]; then
echo "Password is empty! exiting..."
exit 1
fi

echo ""
sleep 3
echo " Adding a new MySQL user $user and creating the database $db";

mysql -h$host -uroot -p$myspwd -Be "create database $db"
mysql -h$host -uroot -p$myspwd -Be "create user '$user'@'%' identified by '$pass';"
mysql -h$host -uroot -p$myspwd -Be "GRANT ALL PRIVILEGES ON $db.* TO '$user'@'%' with grant option;"

#echo "A database was created"
#echo "Testing connection to database"
echo "Creating database....."
sleep 3
#mysql -h$host -uroot -p$myspwd -Be "show databases" | grep $db
echo ""
echo "Testing to connect to $db with user $user...."
mysql -h$host -u$user -p$pass $db -Be "show databases" > /dev/null
if [ "$?" = "0" ]; then
	echo "The connection was succefull!"
	echo "A database $db and user $user was sucessfullly created!"
else
	echo "There where an error!!!"
fi

