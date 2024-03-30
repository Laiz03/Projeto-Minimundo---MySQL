--1) Elabore um mini mundo para resolver algum problema do mundo real.
--Obs: O mini-mundo terá que conter no mínimo 8 entidades, um auto-relacionamento,
--uma herança e uma entidade associativa
--2) Com o mini mundo elaborado, crie o modelo relacional do mesmo, utilizando a
--ferramenta brModelo ou similar.
--3) Transforme o modelo conceitual para o modelo relacional, obedecendo no mínimo a
--3FN (3a. forma normal), primary key, foreign key e check. Nos campos do tipo boolean
--deverá sempre ter valor default true ou false de acordo com a necessidade da regra de
--negócio, nos campos numéricos iniciar sempre com 0 (zero) e campos tipo data de
--pagamento, data de nascimento sempre checar se a data pode ser maior ou menor que a
--data atual. (Exemplo: data de nascimento não pode ser maior que a data atual) ;

create database minimundoo


create table professor (
matricula int primary key not null,
nome varchar(50) not null,
especialidade varchar(50) not null,
salario float not null
);


--4) Criar os scripts de inserção para todas as tabelas;
insert into professor (matricula, nome, especialidade, salario)
values (0, 'bia', 'ciencias', 1.500),
       (1, 'lucas', 'matemat/ica', 2.000),
	   (2, 'ana', 'arte', 2.589)

select* from professor

--5) Altere um valor de chave primária que possua valores nas tabelas relacionadas e
--mostre abaixo o retorno.
update professor 
set salario = 1.615
where salario = 1.500


--6) Exclua um valor de chave primária que possua valores nas tabelas relacionadas e
--mostre abaixo o retorno.

delete from professor
where matricula = 1



create table aluno (
matricula int primary key not null,
nome varchar(50) not null
);

--4) Criar os scripts de inserção para todas as tabelas;
insert into aluno (matricula, nome)
values (0, 'ana')


--7) Alterar em alguma tabela que possua chave estrangeira para UPDATE ON CASCADE /
--DELETE ON CASCADE, e faça o mesmo da questão 5 e 6.
create table notas (
id int primary key not null,
descricao int not null,
cod_professor int not null,
cod_aluno int not null,
foreign key (cod_professor) references professor(matricula) on update cascade,
foreign key (cod_aluno) references aluno (matricula) on delete cascade,
);

--4) Criar os scripts de inserção para todas as tabelas;
insert into notas (id, descricao, cod_professor, cod_aluno)
values (0, 8.5, 0, 0),
       (1, 10.0, 0, 0)


create table disciplina (
id int primary key not null,
descricao varchar(80) not null,
cod_professor int not null,
foreign key (cod_professor) references professor(matricula) on update cascade,
);

--4) Criar os scripts de inserção para todas as tabelas;
insert into disciplina (id, descricao, cod_professor)
values (0, 'ciencias', 0)


create table assunto (
id int primary key not null,
descricao varchar(80) not null,
cod_disciplina int not null,
foreign key (cod_disciplina) references disciplina(id)
);

--4) Criar os scripts de inserção para todas as tabelas;
insert into assunto (id, descricao, cod_disciplina)
values (0, 'seres vivos', 0)


create table secretaria (
id int primary key not null,
procedimentos varchar(80) not null,
funcionarios varchar (50) not null,
direcao_id int not null,
foreign key (direcao_id) references secretaria(id)
);

--4) Criar os scripts de inserção para todas as tabelas;
insert into secretaria (id, procedimentos, funcionarios, direcao_id)
values (0, 'matricula', 'joao', 0),
       (1, 'transferencia', 'maria', 0)


create table laboratorio (
id_laboratorio int primary key not null,
nome varchar(80) not null,
);

--4) Criar os scripts de inserção para todas as tabelas;
insert into laboratorio (id_laboratorio, nome)
values (0, 'ciencias'),
       (1, 'informatica')



create table ciencias (
id_laboratorio int primary key not null,
nome varchar(50) not null,
foreign key (id_laboratorio) references laboratorio(id_laboratorio)
);

--4) Criar os scripts de inserção para todas as tabelas;
insert into ciencias (id_laboratorio, nome)
values (0, 'ciencias')

create table informatica (
id_laboratorio int primary key not null,
nome varchar(50) not null,
foreign key (id_laboratorio) references laboratorio(id_laboratorio)
);

--4) Criar os scripts de inserção para todas as tabelas;
insert into laboratorio (id_laboratorio, nome)
values (2, 'informatica')


--8) Faça uma consulta que mostra todos os campos da maior tabela do seu esquema,
--utilizando filtro e order by.
-- Consulta para encontrar a maior tabela no esquema
select top 1
    t.name AS NomeDaTabela,
    c.name AS NomeDoCampo
FROM
    sys.tables t
JOIN
    sys.columns c ON t.object_id = c.object_id
WHERE
    t.name IN ('professor', 'aluno', 'notas', 'disciplina', 'assunto', 'secretaria', 'laboratorio', 'ciencias', 'informatica') -- Especifica as tabelas do seu esquema



--8) Crie consultas utilizando:
--a) A cláusula IN;

select matricula, salario
from professor
where matricula in (8.5)


--b) LIKE;

select* from professor
WHERE nome LIKE 'b%'

--c) Between;

select* from notas
where descricao between 7.0 and 10.00

--d) Inner Join;

select* from aluno 
inner join professor
on aluno.matricula = professor.matricula

--e) Left Join;

select* from aluno 
left join professor
on aluno.matricula = professor.matricula


--f) Right Join;

select* from aluno 
right join professor
on aluno.matricula = professor.matricula



--9) Crie uma consulta utilizando opções de Grupos: Max, Min, Count, SUM e AGV, utilizando:
--a) com Group by



select nome, avg(salario) 
from professor
group by nome;


select nome, min (salario), max(salario)
from professor
group by nome;


select nome, sum (salario)
from professor
group by nome;


select nome, count(*)
from professor
group by nome;



--b) sem Group by

select 
      avg(salario),
	  min(salario),
	  sum(salario),
	  max(salario),
	  count(salario)
from professor


--c) com Where e Group by

select nome,
      avg(salario),
	  min(salario),
	  sum(salario),
	  max(salario),
	  count(salario)
from professor
where salario > 1.500
group by nome;


--d) com Group by e Having


select cod_aluno,
      avg(descricao),
	  min(descricao),
	  sum(descricao),
	  max(descricao),
	  count(descricao)
from notas
group by cod_aluno
having count(*) > 7.0;


--e) com Where, Group by e Having

select nome,
      avg(salario),
	  min(salario),
	  sum(salario),
	  max(salario),
	  count(salario)
from professor
where salario > 1.500
group by nome
having count(*) > 7.0;



--10) Crie um script para excluir todos os registros de todas as tabelas, respeitando as
--restrições e chaves primárias e estrangeiras.


delete from professor;
delete from aluno;
delete from notas;
delete from disciplina;
delete from assunto;
delete from secretaria;
delete from laboratorio;
delete from ciencias;
delete from informatica;
