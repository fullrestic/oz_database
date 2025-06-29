use testdatabase;

-- create table users(
-- 	id int primary key auto_increment,
--     password varchar(4),
--     name varchar(3),
--     gender enum('male', 'female'),
--     email varchar(15), 
--     birthday char(6),
--     age tinyint,
--     company enum('samsung', 'lg','hyundai')
-- );

create table boards(
	id int primary key auto_increment,
    title varchar(5),
    content varchar(10),
    likes int check(likes between 1 and 100),
    img char(1) default 'c',
    created date,
    user_id int,
    foreign key(user_id) references users(id)
);