#!/bin/bash
#
# zabbix-check.sh                                       ver.1.0.0  2016.01.17
#
# Author:
#     hogehoge hogehoge
#
# Usage:
#     zabbix-check.sh
#
# Description :
#     This script checks zabbix-items-status.
# 
# Caution:
#     You must make $MASTER,$SQL before this script executes.
#
#########################################################################

### Variable
MASTER=/root/Tools/etc/master
TRAN=/root/Tools/etc/trans.txt
SQL=/root/Tools/sql/items.error.sql
LOGS=/root/Tools/log/zabbix-check.log
DATE=`date "+%Y%m%d %H:%M"`
MAIL_TO=hogehoge@hogehoge.com
MAIL_FROM=hogehoge2@hogehoge2.com
SUBJECT=Zabbix-Check

### SQL Execute
mysql -uroot -phogehoge zabbix < ${SQL} > ${TRAN}

### diff
diff ${MASTER} ${TRAN}

if [ $? = 0 ]; then
    echo "${DATE} zabbix-check OK" > ${LOGS}
    echo "zabbix-check OK" | mail -s ${SUBJECT} -r ${MAIL_FROM} ${MAIL_TO}

else
    echo "${DATE} zabbix-check error" > ${LOGS}
    echo "zabbix-check error" | mail -s ${SUBJECT} -r ${MAIL_FROM} ${MAIL_TO}
fi