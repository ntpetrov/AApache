#!/bin/bash
echo "Enter subdomain: "
read SUBDOMAIN
echo "Enter the username (MUST EXIST): "
read USER
echo "Enter dir for the new subodmain: (/var/www/$USER/public_html/XXX) :"
read DIR
if [ -f "/etc/httpd/conf.d/hosts/$subdomain.conf" ]; then
	echo "Subdomain vhost files exist!"
	echo ""
	echo "Exiting....."
fi

cp /etc/httpd/conf.d/sub.template /etc/httpd/conf.d/hosts/$SUBDOMAIN.conf
replace SUBDOMAIN $SUBDOMAIN -- /etc/httpd/conf.d/hosts/$SUBDOMAIN.conf
replace USER $USER -- /etc/httpd/conf.d/hosts/$SUBDOMAIN.conf
replace DIR $DIR -- /etc/httpd/conf.d/hosts/$SUBDOMAIN.conf
echo ""
echo "Creating homedir"
mkdir -p $DIR
echo "Restarting apache........."
service httpd restart
chown -R $USER.$USER $DIR


echo "Do you want to configure database for this subdomain? (Y/N)"
read answer

if [ "$answer" = "y" ] || [ "$answer" = "Y"] ; then
. /root/scripts/mysql_exec.sh
else
        echo "Hasta pronto!"
        exit 0
fi
