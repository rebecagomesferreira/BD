use saladeaula;
-- -------------------------------------------------------------------
-- ----------------------- ATIVIDADE ---------------------------------
-- -------------------------------------------------------------------

-- Preparação:

-- - execute o script "sala-ddl.sql"
-- - após o banco criado, execute o script "sala-dml.sql"

-- Responda as questões abaixo, quando for discursiva, escreva em comentários

-- 1) O que você achou da forma como o banco foi populado (arquivo sala-dml.sql)?
--      Há formas melhores de ter feito esse preenchimento? Como?
--      Como melhorar esse script usando comandos TCL?
--      Obs.: Essa questão é discursiva, não envie códigos nela.



-- 2) É mais comum buscar pessoas por documentos, crie um índice para CPF na tabela de Pessoa. (código de criação do índice)
create index pessoa_cpf on
pessoa(cpf);


-- 3) Em Avaliacao, há um campo TEXT, o campo ocorrencia, que contém ocorrências ocorridas durante as avaliações
-- a)   crie um FULLTEXT INDEX para esse campo, inclua o tipo_prova no índice
create fulltext index avaliacao_ocorrencia on 
avaliacao(ocorrencia);

-- b)   faça uma busca por suspeitas de cola na P3 utilizando apenas o índice
select id, tipo_prova, ocorrencia
from avaliacao
where tipo_prova = 'P3' and ocorrencia like '%cola%';


-- 4) Quais os benefícios e cuidados com a criação desses índices?



-- 5) Crie uma VIEW que gere uma tabela virtual com os estudantes que estão regularmente matriculados e que não estão sob medidas disciplinares formais,
--  mas possuem registros de ocorrências durante avaliações.
create view estudante_regulados as
select aluno.matricula, aluno.pessoa_id
from aluno
inner join aluno_turma 
on aluno_turma.aluno_mat = aluno.matricula
inner join avaliacao 
on avaliacao.aluno_turma_id = aluno_turma.aluno_mat
where aluno.status = 'ativo' and avaliacao.ocorrencia is not null;

select * from estudante_regulados;

-- 6) Crie duas VIEWs, uma para apresentar os dados do professor (tabelas Professor e Pessoa) e outra para apresentar os dados dos alunos (tabelas Pessoa e Aluno).
create view professor_pessoa as
select * 
from professor
inner join pessoa
on pessoa.ID = professor.pessoa_id;
select * from professor_pessoa;

create view aluno_pessoa as
select * 
from aluno
inner join pessoa
on pessoa.id = aluno.pessoa_id;
select * from aluno_pessoa;


-- 7) Crie uma ROLE Secretaria, que terá permissão de acesso a todo o banco, mas não poderá excluir nenhum dado.
create role 'Secretaria';
grant select, insert, update, index, alter, create, execute on saladeaula.* to 'Secretaria';
flush privileges;

-- 8) Crie um usuário Maria, Maria é secretária acadêmica, atribua os acesso de Secretaria a Maria.
create user 'maria'@'localhost' identified by 'sctACD1234';
grant 'Secretaria' to 'maria'@'localhost';
flush privileges;


-- 9) Crie uma TRIGGER que zere a nota de uma avaliação caso seja inserida com uma ocorrência que justifique isso.
delimiter //
create trigger zerar_nota
before insert on saladeaula.avaliacao
for each row
begin
if ocorrencia = "Presença de dispositivos eletrônicos não permitidos" then 
set new.nota = 0.0;
end if;
end //
delimiter ;

select * from avaliacao;

drop trigger zerar_nota;

-- 10) Crie uma TRIGGER que zere a nota de uma avaliação caso seja atualizada adicionando uma ocorrência que justifique isso.



-- 11) Crie uma (ou mais) FUNCTION que calcule a nota final por disciplina e aluno.



-- 12) Crie uma PROCEDURE que, caso o aluno tenha 3 ou mais ocorrências, deverá ser suspenso, caso esteja suspenso e tenha 9 ou mais ocorrências, expulso.

