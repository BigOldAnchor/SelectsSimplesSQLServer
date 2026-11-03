CREATE DATABASE Locadora
GO
USE Locadora

CREATE TABLE Estrela (
	ID INT NOT NULL IDENTITY (9901, 1),
	nome VARCHAR(50) NOT NULL
	PRIMARY KEY (ID)
)
CREATE TABLE Filme (
	ID INT NOT NULL IDENTITY (1001, 1),
	titulo VARCHAR(40) NOT NULL,
	ano INT NULL CHECK (ano <= 2021)
	PRIMARY KEY (ID)
)
CREATE TABLE Cliente (
	num_cadastro INT NOT NULL IDENTITY (5501, 1),
	nome VARCHAR(70) NOT NULL,
	logradouro VARCHAR(150) NOT NULL,
	num INT NOT NULL CHECK (num > 0),
	cep char(8) NULL CHECK (LEN(cep) = 8)
	PRIMARY KEY (num_cadastro)
)
GO
CREATE TABLE Filme_Estrela (
	Filmeid INT NOT NULL,
	Estrelaid INT NOT NULL
	PRIMARY KEY (Filmeid, EstrelaID),
	FOREIGN KEY (Filmeid) REFERENCES Filme(ID),
	FOREIGN KEY (Estrelaid) REFERENCES Estrela(ID)
)
GO
CREATE TABLE DVD (
	num INT NOT NULL IDENTITY(10001,1) ,
	data_fabricacao DATE NOT NULL CHECK (data_fabricacao < GETDATE()),
	Filmeid INT NOT NULL
	PRIMARY KEY (num),
	FOREIGN KEY	(Filmeid) REFERENCES Filme(ID)
)
GO
CREATE TABLE Locacao (
	DVDNum INT NOT NULL,
	Clientenum_cadastro INT NOT NULL,
	data_locacao DATE NOT NULL DEFAULT(GETDATE()),
	data_devolucao DATE NOT NULL,
	valor decimal(7,2) NOT NULL CHECK(valor > 0)
	PRIMARY KEY (DVDnum, Clientenum_cadastro, data_locacao),
	CHECK (data_locacao < data_devolucao),
	FOREIGN KEY (DVDnum) REFERENCES DVD (num),
	FOREIGN KEY (Clientenum_cadastro) REFERENCES Cliente(num_cadastro)
)

-- Alteração de tabelas
ALTER TABLE Estrela
ADD nome_real VARCHAR(50);

ALTER TABLE Filme
ALTER COLUMN titulo VARCHAR(80);

-- Inserção de Dados
INSERT INTO Filme (titulo, ano)
VALUES
    ('Whiplash', 2015),
    ('Birdman', 2015),
    ('Interestelar', 2014),
    ('A Culpa é das estrelas', 2014),
    ('Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', 2014),
    ('Sing', 2016);
GO
INSERT INTO Estrela (nome, nome_real)
VALUES 
    ('Michael Keaton', 'Michael John Douglas'),
    ('Emma Stone', 'Emily Jean Stone'),
    ('Miles Teller', NULL),
    ('Steve Carell', 'Steven John Carell'),
    ('Jennifer Garner', 'Jennifer Anne Garner');
GO
INSERT INTO Filme_Estrela (FilmeId, EstrelaId)
VALUES
    (1002, 9901),
    (1002, 9902),
    (1001, 9903),
    (1005, 9904),
    (1005, 9905);
GO
INSERT INTO DVD (data_fabricacao, FilmeId)
VALUES
    ('2020-12-02', 1001),
    ('2019-10-18', 1002),
    ('2020-04-03', 1003),
    ('2020-12-02', 1001),
    ('2019-10-18', 1004),
    ('2020-04-03', 1002),
    ('2020-12-02', 1005),
    ('2019-10-18', 1002),
    ('2020-04-03', 1003);
GO
INSERT INTO Cliente (Nome, Logradouro, Num, CEP)
VALUES
    ('Matilde Luz', 'Rua Síria', 150, '03086040'),
    ('Carlos Carreiro', 'Rua Bartolomeu Aires', 1250, '04419110'),
    ('Daniel Ramalho', 'Rua Itajutiba', 169, NULL),
    ('Roberta Bento', 'Rua Jayme Von Rosenburg', 36, NULL),
    ('Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110');
GO
INSERT INTO Locacao (DVDnum, ClienteNum_Cadastro, Data_Locacao, Data_Devolucao, Valor)
VALUES
    (10001, 5502, '2021-02-18', '2021-02-21', 3.50),
    (10009, 5502, '2021-02-18', '2021-02-21', 3.50),
    (10002, 5503, '2021-02-18', '2021-02-19', 3.50),
    (10002, 5505, '2021-02-20', '2021-02-23', 3.00),
    (10004, 5505, '2021-02-20', '2021-02-23', 3.00),
    (10005, 5505, '2021-02-20', '2021-02-23', 3.00),
    (10001, 5501, '2021-02-24', '2021-02-26', 3.50),
    (10008, 5501, '2021-02-24', '2021-02-26', 3.50);
GO
UPDATE Cliente
SET CEP = '08411150'
WHERE Num_cadastro = 5503;

UPDATE Cliente
SET CEP = '02918190'
WHERE Num_cadastro = 5504;

UPDATE Locacao
SET Valor = 3.25
WHERE ClienteNum_Cadastro = 5502 AND Data_Locacao = '2021-02-18';

UPDATE Locacao
SET Valor = 3.10
WHERE ClienteNum_Cadastro = 5501 AND Data_Locacao = '2021-02-24';

UPDATE DVD
SET Data_fabricacao = '2019-07-14'
WHERE Num = 10005;

UPDATE Estrela
SET nome = 'Miles Alexander Teller'
WHERE nome = 'Miles Teller';

DELETE FROM Filme
WHERE titulo = 'Sing';

-- Consultas
SELECT titulo FROM Filme WHERE ano = 2014;

SELECT id, ano FROM Filme WHERE titulo = 'Birdman';

SELECT id, ano FROM Filme WHERE titulo LIKE '%plash';

SELECT id, nome, nome_real FROM Estrela WHERE nome LIKE 'Steve%';

SELECT Filmeid,
       CONVERT(CHAR(10), data_fabricacao, 103) as fab
       FROM DVD WHERE data_fabricacao >= '2020-01-01';

SELECT DVDnum, data_locacao, data_devolucao, valor, 
       CAST(valor + 2.00 AS DECIMAL(7,2)) AS multa_acrescimo
       FROM Locacao WHERE Clientenum_cadastro = 5505;

SELECT Logradouro + ', ' + CAST(num AS VARCHAR(6)) + ' | ' + CEP as endereco
       FROM Cliente WHERE nome = 'Matilde Luz';

SELECT nome_real FROM Estrela WHERE nome = 'Michael Keaton';

SELECT num_cadastro, nome,
       Logradouro + ', ' + CAST(num AS VARCHAR(6)) + ' | ' + CEP as end_comp
       FROM Cliente WHERE num_cadastro >= 5503;