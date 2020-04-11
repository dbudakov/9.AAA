Для доступа к машине по паролю через `ssh` необходимо попровить директиву в `/etc/ssh/sshd_config`  
```
sed
```
Обязательно прописываем время в настройке `/etc/secure/time.conf` справка пункт `1.5` [здесь](https://xubuntu-ru.net/how-to/101-roditelskiy-kontrol-posredstvom-linux-pam.html)  
```
*;*;user1;!Wd0000-2400
```
строка для `/etc/crontab`, на завершение сеанса `user1`
```
*  *  *  *  * root pkill -9 -u user1
```
Создаем скрит для `cron` на изменение участников в группе
```sh
a=$(awk -F: '/users/ {print $NF}' /etc/group|sed 's/,/|/g') 
sed -i '/rule1/d' /etc/security/time.conf
echo '*;*;'$a';!Wd0000-2400 #rule1' >> /etc/security/time.conf  
```

Дополнительные утилиты:  
```sh
gpasswd -d [username] [groupname] #удаление пользователя из группы
```
