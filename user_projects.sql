CREATE DATABASE user_projects
GO
USE user_projects
GO
CREATE TABLE users (
	id INT NOT NULL IDENTITY(1,1),
	realName VARCHAR(45) NULL,
	userName VARCHAR(45) NULL UNIQUE,
	userPassword VARCHAR (45) NULL DEFAULT('123mudar'),
	email VARCHAR(45) NULL
	PRIMARY KEY (id)
)
CREATE TABLE projects (
	id INT NOT NULL IDENTITY(10001, 1),
	projectName VARCHAR(45) NULL,
	projectDescription VARCHAR(45) NULL,
	projectDate DATE NULL CHECK (projectDate > '2014-09-01')
	PRIMARY KEY (id)
)
GO 
CREATE TABLE users_has_projects (
	users_id INT NOT NULL,
	projects_id INT NOT NULL
	PRIMARY KEY (users_id, projects_id),
	FOREIGN KEY (users_id) REFERENCES users(id),
	FOREIGN KEY (projects_id) REFERENCES projects(id),
)
---- MODIFICAÇÃO DE COLUNAS
--ALTER TABLE users ALTER COLUMN userName VARCHAR(10)
--ALTER TABLE users ALTER COLUMN userPassword VARCHAR(8)

-- Inserção de dados na tabela Users
INSERT INTO Users (realName, userName, userPassword, email)
VALUES
    ('Maria', 'Rh_maria', '123mudar', 'maria@empresa.com'),
    ('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
    ('Ana', 'Rh_ana', '123mudar', 'ana@empresa.com'),
    ('Clara', 'Ti_clara', '123mudar', 'clara@empresa.com'),
    ('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com');


-- Inserção de dados na tabela Projects
INSERT INTO Projects (projectName, projectDescription, projectDate)
VALUES
    ('Re-folha', 'Refatoração das Folhas', '2014-09-05'),
    ('Manutenção PC´s', 'Manutenção PC´s', '2014-09-06'),
    ('Auditoria', NULL, '2014-09-07');

-- Inser;çao de dados na tabela user_has_projects
INSERT INTO users_has_projects(users_id, projects_id)
VALUES
	(1, 10001),
	(2, 10001),
	(3, 10003),
	(4, 10002),
	(5, 10002);


-- Modificação de dados
UPDATE projects
SET projectDate = '2014-09-12' 
WHERE id = 10002;

UPDATE users
SET userName = 'Rh_cido'
WHERE realName = 'Aparecido';

UPDATE users
SET userPassword = '888@*'
WHERE userName = 'Rh_maria' AND userPassword = '123mudar';

DELETE FROM users_has_projects WHERE users_id = 2;