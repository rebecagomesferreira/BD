drop database aula3;
create database aula3;
use aula3;

create table autor(
id_autor int primary key,
nome_autor varchar(250)
);

insert into autor(id_autor, nome_autor)
values('12345', "Haruki Murakami");

select id_autor, nome_autor
from autor;

create table livro(
isbn varchar(250) primary key,
titulo varchar(250), 
ano int,
id_autor int,
constraint autor_id
foreign key (id_autor)
references autor(id_autor)
);

insert into livro(isbn, id_autor, titulo, ano)
values("9780375704024", '12345', "Norwegian Wood", '1987');

select isbn, titulo, id_autor, ano
from livro;

create table if not exists pessoa(
id_pessoa int primary key,
cpf int, 
nome varchar(250), 
data_nasc date,
saldo decimal(10,2) default 0.00
);

insert into pessoa(id_pessoa, cpf, nome, data_nasc, saldo)
values('54321', '863216371', 'Rebeca', '2005-08-22', '13.9');

select id_pessoa, cpf, nome, data_nasc, saldo
from pessoa;


create table emprestimo(
id_empres int primary key,
data_empres timestamp default current_timestamp,
data_dev timestamp default current_timestamp,
id_pessoa int,
isbn varchar(250),
constraint pessoa_id
foreign key (id_pessoa)
references pessoa(id_pessoa),
constraint isbn_id
foreign key (isbn)
references livro(isbn)
);

insert into emprestimo(id_empres, data_empres, data_dev, id_pessoa, isbn)
values('32415', NOW(), NOW() + INTERVAL 15 DAY, '54321', '9780375704024');

select id_empres, data_empres, data_dev, id_pessoa, isbn
from emprestimo;
