-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE contato_tipo (
idcontato_tipo VARCHAR(10) PRIMARY KEY,
descricao VARCHAR(60)
)

CREATE TABLE responsavel_contato (
contato VARCHAR(200),
principal INTEGER,
idresponsavel_contato VARCHAR(10) PRIMARY KEY,
idcontato_tipo VARCHAR(10),
idresponsavel VARCHAR(10),
FOREIGN KEY(idcontato_tipo) REFERENCES contato_tipo (idcontato_tipo)
)

CREATE TABLE responsavel (
nome VARCHAR(10),
receber_notificacao VARCHAR(10),
idresponsavel VARCHAR(10) PRIMARY KEY,
idendereco INTEGER
)

CREATE TABLE bairro (
idbairro INTEGER PRIMARY KEY,
nome VARCHAR(100)
)

CREATE TABLE cidade (
idcidade VARCHAR(10) PRIMARY KEY,
nome VARCHAR(100)
)

CREATE TABLE endereco (
idendereco INTEGER PRIMARY KEY,
endereo VARCHAR(200),
cep VARCHAR(9),
numero VARCHAR(20),
idbairro INTEGER,
idcidade VARCHAR(10),
FOREIGN KEY(idbairro) REFERENCES bairro (idbairro),
FOREIGN KEY(idcidade) REFERENCES cidade (idcidade)
)

CREATE TABLE curso (
descricao VARCHAR(60),
idcurso INTEGER PRIMARY KEY
)

CREATE TABLE turma (
idturma INTEGER PRIMARY KEY,
descricao VARCHAR(60),
hora_saida2 VARCHAR(10),
hora_inicio1 VARCHAR(10),
hora_saida1 VARCHAR(10),
hora_inicio2 VARCHAR(10),
idcurso INTEGER,
FOREIGN KEY(idcurso) REFERENCES curso (idcurso)
)

CREATE TABLE aluno_log (
hora TIME,
idaluno_log VARCHAR(10) PRIMARY KEY,
data DATETIME,
idaluno VARCHAR(10)
)

CREATE TABLE aluno_turma (
matriculado INTEGER,
data DATETIME,
idaluno_turma VARCHAR(10) PRIMARY KEY,
idturma INTEGER,
idaluno VARCHAR(10),
FOREIGN KEY(idturma) REFERENCES turma (idturma)
)

CREATE TABLE aluno (
idaluno VARCHAR(10) PRIMARY KEY,
codigo VARCHAR(20),
matricula VARCHAR(20),
nome VARCHAR(100),
idendereco INTEGER,
FOREIGN KEY(idendereco) REFERENCES endereco (idendereco)
)

CREATE TABLE aluno_responsavel (
idaluno VARCHAR(10),
idresponsavel VARCHAR(10),
FOREIGN KEY(idaluno) REFERENCES aluno (idaluno),
FOREIGN KEY(idresponsavel) REFERENCES responsavel (idresponsavel)
)

ALTER TABLE responsavel_contato ADD FOREIGN KEY(idresponsavel) REFERENCES responsavel (idresponsavel)
ALTER TABLE responsavel ADD FOREIGN KEY(idendereco) REFERENCES endereco (idendereco)
ALTER TABLE aluno_log ADD FOREIGN KEY(idaluno) REFERENCES aluno (idaluno)
ALTER TABLE aluno_turma ADD FOREIGN KEY(idaluno) REFERENCES aluno (idaluno)
