#! /bin/bash

GLINES=`cat /etc/group`

for line in $GLINES; do
    GROUPNAME=`echo $line |cut -d: -f1`
    GIDNUMBER=`echo $line |cut -d: -f3`
    GPASSWORD=`echo $line | cut -d: -f2`
    GMEMBERS=`echo $line | cut -d: -f4`
    if [[ "$GIDNUMBER" -ge 500 && "$GIDNUMBER" -le 6000 || "$GIDNUMBER" -eq 0  ]]; then
        echo "dn: cn=$GROUPNAME,ou=people,dc=utopia,dc=net"
        echo "objectClass: posixGroup"
        echo "cn: $GROUPNAME"
        echo "userPassword: {crypt}$GPASSWORD"
        echo "gidNumber: $GIDNUMBER"
                GMEMBERS=`echo $GMEMBERS | sed s/,/\ /`
                for member in $GMEMBERS; do
                echo "memberUid: $member"
                done
	echo "" 
     fi
done
