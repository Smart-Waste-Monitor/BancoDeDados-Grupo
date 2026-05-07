CREATE DATABASE Smart_Waste;
USE Smart_Waste;

-- TABELA: hospital
CREATE TABLE hospital (
    idhospital INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cnpj VARCHAR(20),
    email VARCHAR(100),
    codigo_ativacao VARCHAR(50) UNIQUE,
    telefone VARCHAR(20)
);


-- TABELA: usuario
CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    senha VARCHAR(100),
    fkhospital INT,
    FOREIGN KEY (fkhospital) REFERENCES hospital(idhospital)
);

-- TABELA: endereco
CREATE TABLE endereco (
idEndereco INT,
rua VARCHAR(45),
complemento VARCHAR(45),
bairro VARCHAR(45),
CEP VARCHAR(45),
fk_hospital_idhospital INT,
FOREIGN KEY (fkhospital) REFERENCES hospital(idhospital)
);

-- TABELA: local
CREATE TABLE local (
    idLocal INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(150),
    fkhospital INT,
    FOREIGN KEY (fkhospital) REFERENCES hospital(idhospital)
);

-- TABELA: sensor
CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(50),
    statusSensor VARCHAR(20)
);

-- TABELA: tipoResiduo
CREATE TABLE tipoResiduo (
    idTipo INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(50),
    capacidadeMaxima FLOAT
);


-- TABELA: lixeira
CREATE TABLE lixeira (
    idLixeira INT PRIMARY KEY AUTO_INCREMENT,
    identificacao VARCHAR(50),
    capacidadeMaxima FLOAT,
    fk_local_idLocal INT,
    fk_tipoResiduo_idTipo INT,
    fk_sensor_idSensor INT,
    fkhospital INT,
    FOREIGN KEY (fk_local_idLocal) REFERENCES local(idLocal),
    FOREIGN KEY (fk_tipoResiduo_idTipo) REFERENCES tipoResiduo(idTipo),
    FOREIGN KEY (fk_sensor_idSensor) REFERENCES sensor(idSensor),
    FOREIGN KEY (fkhospital) REFERENCES hospital(idhospital)
);

-- TABELA: leitura (dados do sensor)
CREATE TABLE leitura (
    idLeitura INT PRIMARY KEY AUTO_INCREMENT,
    volumeAtual FLOAT,
    percentualPreenchido FLOAT,
    dataHora DATETIME,
    fk_sensor_idSensor INT,
    FOREIGN KEY (fk_sensor_idSensor) REFERENCES sensor(idSensor)
);

-- TABELA: alerta
CREATE TABLE alerta (
    idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    nivel VARCHAR(50),
    mensagem VARCHAR(200),
    dataHora DATETIME,
    leitura_idLeitura INT,
    FOREIGN KEY (leitura_idLeitura) REFERENCES leitura(idLeitura)
);

-- TABELA: contato
CREATE TABLE contato (
    idContato INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100),
    assunto VARCHAR(150),
    mensagem TEXT,
    dataEnvio DATETIME
);

-- INSERTS INICIAIS
INSERT INTO tipoResiduo (descricao) VALUES
('A - Infectante'),
('B - Químico'),
('C - Radioativo'),
('D - Comum'),
('E - Perfurocortante');



/*
UPDATE empresa
SET codigo_ativacao = '321'
WHERE idEmpresa = 2;

-- drop DATABASE smart_waste;

SELECT * from empresa;
SELECT * from usuario;
*/
