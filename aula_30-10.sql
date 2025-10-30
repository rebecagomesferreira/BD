use biblioteca;

-- trigger
delimiter //
create trigger validar_idade
before insert 
on biblioteca.pessoa for each row
begin 
if timestampdiff(year, new.data_nasc, curdate()) < 5 then
set new.data_nasc = date_sub(curdate(), interval 5 year);
elseif timestampdiff(year, new.data_nasc, curdate()) > 100 then
set new.data_nasc = date_sub(curdate(), interval 100 year);
end if;
end //
delimiter ;

select * from autor;

delimiter //
create trigger valor_multa
before  
on biblioteca.livro for each row
begin
if new.valor_multa < 1.0 then
set new.valor_multa = 1.0;
end if;
end //
delimiter ;

insert into livro(isbn, titulo, ano, valor_multa, autorID) values
('434246447752', "Livro 3", '2025', '0.50', 1);

select * from livro; 

-- funções

delimiter //
create function calcular_multa(data_emprestimo timestamp, data_devolucao timestamp, valor_multa decimal(10,2))
returns decimal(10,2)
deterministic
begin
declare valor decimal(10,2);
if timestampdiff(day, data_emprestimo, data_devolucao) < 7 then
set valor = 0.0;
else
set valor = valor_multa * (timestampdiff(day, data_emprestimo, data_devolucao) - 7);
end if;
return valor;
end //
delimiter ;

select p.cpf, p.nome, l.titulo, calcular_multa(e.data_emprestimo, e.data_devolucao, l.valor_multa) as multa
from pessoa p
inner join emprestimo e
on e.pessoa_id = p.id
inner join livro l
on l.isbn = e.isbn_livro;

select * from pessoa;

-- procedures

select* from pessoa;

update pessoa
set saldo = -123
where id = 1;

delimiter //
create procedure negativados(in novo_valor decimal(8,2))
begin
update pessoa
set saldo = novo_valor
where saldo < 0;
end //
delimiter ;

set SQL_SAFE_UPDATES = 0;

call negativados(0);

SELECT * FROM pessoa;