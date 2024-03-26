-- Creacion y uso de DB 

create schema alke_wallet;
use alke_wallet;

-- Creacion de Tablas

-- Tabla Usuarios
create table usuarios(
user_id int primary key auto_increment,
nombre varchar(50) not null,
email varchar(50) not null unique,
contrasena varchar(15) not null,
saldo double not null
);


-- Tabla Monedas

create table monedas(
currency_id int primary key auto_increment,
currency_name varchar(20) not null,
currency_symbol varchar(5) not null
);

-- Tabla monedaXusuario para asociar una moneda determinada a un usuario

create table moneda_usuario(
user_id int unique,
currency_id int,
foreign key (user_id) references usuarios (user_id),
foreign key(currency_id) references monedas (currency_id)
);

-- Tabla Transacciones

create table transacciones (
id_transaccion int primary key auto_increment,
sender_user_id int not null,
receiver_user_id int not null,
importe double not null,
transaction_date datetime,
foreign key (sender_user_id) references usuarios(user_id),
foreign key (receiver_user_id) references usuarios(user_id)
);

-- Poblar Tablas

insert into usuarios (nombre, email, contrasena, saldo) values
('George Bluth', 'george.bluth@reqres.in','123456',100000),
('Janet Weaver','janet.weaver@reqres.in','123456',200000),
('Emma Wong','emma.wong@reqres.in','123456',300000),
('Eve Holt','eve.holt@reqres.in','123456',400000),
('Charles  Morris','charles.morris@reqres.in','123456',500000),
('Tracey ramos','tracey.ramos@reqres.in','123456',600000);

insert into monedas(currency_name,currency_symbol) values
('US Dollar','$'),
('Chilean Peso','$'),
('Great Britain pound','£');

insert into moneda_usuario(user_id,currency_id) values 
((select user_id from usuarios where nombre = 'George Bluth'),(select currency_id from monedas where currency_name = 'US Dollar')),
((select user_id from usuarios where nombre = 'Janet Weaver'),(select currency_id from monedas where currency_name = 'US Dollar')),
((select user_id from usuarios where nombre = 'Emma Wong'),(select currency_id from monedas where currency_name = 'Chilean Peso')),
((select user_id from usuarios where nombre = 'Eve Holt'),(select currency_id from monedas where currency_name = 'Chilean Peso')),
((select user_id from usuarios where nombre = 'Charles  Morris'),(select currency_id from monedas where currency_name = 'Great Britain pound')),
((select user_id from usuarios where nombre = 'Tracey ramos'),(select currency_id from monedas where currency_name = 'Great Britain pound'));


insert into transacciones(sender_user_id,receiver_user_id,importe,transaction_date) values
(1,2,3000,now()),
(2,1,7000,now()),
(2,1,4000,now()),
(3,4,15000,now()),
(4,3,20000,now()),
(3,4,7000,now()),
(5,6,4000,now()),
(6,5,37000,now()),
(5,6,34000,now());

-- Consultas

-- Consulta para obtener el nombre de la moneda elegida por un usuario específico

/*
select u.nombre, m.currency_name from
monedas m
inner join moneda_usuario mu on m.currency_id = mu.currency_id
inner join usuarios u on mu.user_id = u.user_id
where u.nombre = 'Nombre usuario';
*/

select u.nombre, m.currency_name from
monedas m
inner join moneda_usuario mu on m.currency_id = mu.currency_id
inner join usuarios u on mu.user_id = u.user_id
where u.nombre = 'Emma Wong';

-- Consulta para obtener todas las transacciones realizadas por un usuario específico

/* 	Solo Realizadas por usuario

Select * 
from transacciones t
where sender_user_id = (select user_id from usuarios where nombre = 'nombre de usuario');
*/

Select * 
from transacciones t
where sender_user_id = (select user_id from usuarios where nombre = 'Charles  Morris');

/* 	Recibidas y Realizadas

Select * 
from transacciones t
where sender_user_id = (select user_id from usuarios where nombre = 'nombre de usuario')
OR receiver_user_id = (select user_id from usuarios where nombre = 'nombre de usuario');
*/

Select * 
from transacciones t
where sender_user_id = (select user_id from usuarios where nombre = 'Janet Weaver')
OR receiver_user_id = (select user_id from usuarios where nombre = 'Janet Weaver');

-- Sentencia DML para modificar el campo correo electrónico de un usuario específico

/*
UPDATE usuarios
set email='nuevo email'
where user_id = 'user_id a modificar';
*/

UPDATE usuarios
set email='eve.holt@gmail.com'
where user_id = 4;

-- Sentencia para eliminar los datos de una transacción (eliminado de la fila completa)

/*
DELETE FROM transacciones 
where id_transaccion='id_transaccion a eliminar)'
*/

DELETE FROM transacciones 
where id_transaccion=6;
