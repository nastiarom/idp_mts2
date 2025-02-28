# Введение в платформы данных. Домашнее задание №2

Инструкция содержит шаги для выполнения задания ***без использования автоматизированных скриптов***(везде где встречаются имена нод или адреса нужно вводить свои).

Попробовала сделать скрипты для автоматизированного выполнения без привязки к среде. 
Нужно сделать файлы исполняемыми:
```bash
chmod +x *.sh
```
И запустить файл init.sh, передав имена нод и имя пользователя в качестве параметров следующим образом:
```bash
./deploy_hadoop.sh 176.109.91.28 team nn dn-00 dn-01
```
Затем нужно вручную выполнить команду, вместо $NAMENODE подставив имя своей нейм ноды:
```bash
ssh -L 9870:$NAMENODE:9870 -L 8088:$NAMENODE:8088 -L 19888:$NAMENODE:19888 "$USER@$JUMP_NODE"
```
Также я вручную добавила пользователя hadoop в файл sudoers чтобы у него появились права sudo.

***P.S. узнала о своей ошибке со средой слишком поздно, поэтому автоматизация получилась довольно кривая, но к следующей домашке постараюсь исправиться...***
