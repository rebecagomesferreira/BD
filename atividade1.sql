CREATE DATABASE atividade1;
USE atividade1;

CREATE TABLE IF NOT EXISTS pessoa(
CPF varchar(11) primary key,
NOME varchar(250),
DATA_NASCIMENTO date
);

INSERT INTO pessoa(cpf, nome, data_nascimento)
VALUES
('09876543221', 'Rebeca', '2005-08-22'),
('34743274382', 'Ana', '2006-09-23'), 
('10929392332', 'Clara', '2005-10-24');

SELECT cpf, nome, data_nascimento
FROM pessoa;

CREATE TABLE IF NOT EXISTS curso(
ID_CURSO int primary key,
NOME varchar(250)
);

INSERT INTO curso(id_curso, nome)
VALUES
('982', 'Engenharia de Software'),
('198', 'Engenharia Eletrica'),
('123', 'Engenharia Civil');

SELECT id_curso, nome
FROM curso;

CREATE TABLE IF NOT EXISTS turma(
codigo_turma int primary key,
semestre varchar(50),
ID_CURSO int,
CONSTRAINT CURSO_ID
FOREIGN KEY (ID_CURSO)
REFERENCES curso(ID_CURSO)
);

INSERT INTO turma(codigo_turma, semestre, id_curso)
VALUES
('5454545', 'segundo', '982'),
('9898989', 'terceiro', '198'),
('2323232', 'quarto', '123');

SELECT codigo_turma, semestre, id_curso
FROM turma;

CREATE TABLE IF NOT EXISTS aluno(
MATRICULA int AUTO_INCREMENT PRIMARY KEY,
ENTRADA char(7) ,
ATIVO int,
ID_CURSO int,
codigo_turma int,
CONSTRAINT CURSO_FK
FOREIGN KEY (ID_CURSO) 
REFERENCES curso(ID_CURSO),
CONSTRAINT ID_TURMA
FOREIGN KEY (codigo_turma)
REFERENCES turma(codigo_turma)
);

INSERT INTO aluno(matricula, entrada, ativo, id_curso, codigo_turma)
VALUES 
(NULL, '2024-01', '1', '982', '2323232'),
(NULL,'2024-02', '1', '198', '5454545'),
(NULL,'2025-01', '0', '123', '9898989');

SELECT matricula, entrada, ativo, id_curso, codigo_turma
FROM aluno;

CREATE TABLE IF NOT EXISTS autor(
ID_AUTOR int primary key
);

INSERT INTO autor(id_autor)
VALUES
(12345), 
(32415),
(54321);

SELECT id_autor
FROM autor;

CREATE TABLE IF NOT EXISTS livro(
ISBN int primary key,
TITULO varchar(250),
ANO int,
EDITORA varchar(250),
ID_AUTOR int,
CONSTRAINT AUTOR_ID
FOREIGN KEY (ID_AUTOR)
REFERENCES autor(ID_AUTOR)
);

INSERT INTO livro(isbn, id_autor, titulo, ano, editora)
VALUES
('948326444', '12345', 'A Revolução dos Bichos', '1945', 'Secker & Warburg'),
('938483499', '32415', 'O Hobbit', '1937', 'George Allen & Unwin'),
('902378222', '54321', 'Dom Casmurro', '1899', 'Tipografia Garnier');

SELECT isbn, id_autor, titulo, ano, editora
FROM livro;

CREATE TABLE IF NOT EXISTS emprestimo(
ID_EMPRESTIMO int primary key,
DATA_EMPRESTIMO date,
DATA_DEVOLUCAO date,
ISBN int,
MATRICULA int,
CONSTRAINT LIVRO_ISBN FOREIGN KEY (ISBN)
REFERENCES livro(ISBN),
CONSTRAINT ALUNO_MATRICULA FOREIGN KEY(MATRICULA)
REFERENCES aluno(MATRICULA)
);

INSERT INTO emprestimo(id_emprestimo, isbn, matricula, data_emprestimo, data_devolucao)
VALUES
('7463536', '902378222', '1', '2025-08-13', '2025-08-27'),
('9947237', '938483499', '2', '2025-08-15', '2025-08-30'),
('0292727', '948326444', '3', '2025-08-10', '2025-08-25');
SELECT id_emprestimo, isbn, matricula, data_emprestimo, data_devolucao

FROM emprestimo;
