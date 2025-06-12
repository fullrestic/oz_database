create user 'fishbread_user'@'localhost' identified by 'fishbread';

grant all privileges on *.* to 'fishbread_user'@'localhost';
flush privileges;

show grants for 'fishbread_user'@'localhost';
show grants;