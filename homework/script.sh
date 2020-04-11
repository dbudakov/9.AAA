#!/bin/bash

for i in admin user1 user2;do useradd $i;done
for i in admin user1 user2;do echo "vagrant"|sudo passwd --stdin $i;done
for i in user1 user2;do gpasswd -a $i users;done

sed -i 's!^PasswordAuthentication.*$!PasswordAuthentication yes!' /etc/ssh/sshd_config
systemctl restart sshd.service

cat >> /root/USERS <<MEMBERS
#!/bin/bash
a=\\$(awk -F: '/users/ {print $NF}' /etc/group|sed 's/,/|/g') 
sed -i '/rule1/d' /etc/security/time.conf
echo '*;*;'\\$a';!Wd0000-2400 #rule1' >> /etc/security/time.conf 
MEMBERS
chmod +x /root/USERS && /root/USERS
cat >> /etc/crontab << TASKS
*  *  *  *  * root pkill -9 -u user1
полное дополнение для cron
*/1  *  *  *  * root echo -e "######   ###   ###### \\n  odd minutes \\n######   ###   ######"|wall
*/2  *  *  *  * root echo -e "######   ###   ###### \\n  even minutes left \\n######   ###   ######"|wall
*/5  *  *  *  *   root pkill -9 -u user1
  *  *  *  *  *   root /root/USERS
# 30 17 *  *  fri #время для предупреждения за 30 минут до сброса сессий
# 45 17 *  *  fri #время для предупреждения за 15 минут до сброса сессий
TASKS
systemctl restart crond.service
