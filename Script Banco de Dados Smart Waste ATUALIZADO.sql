CREATE DATABASE smart_waste;
USE smart_waste;

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
idEndereco INT PRIMARY KEY AUTO_INCREMENT,
rua VARCHAR(45),
complemento VARCHAR(45),
bairro VARCHAR(45),
CEP VARCHAR(45),
fkhospital INT,
FOREIGN KEY (fkhospital) REFERENCES hospital(idhospital)
);

-- TABELA: local
CREATE TABLE local_lixeira (
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
    fk_localLixeira_idLocal INT,
    fk_tipoResiduo_idTipo INT,
    fk_sensor_idSensor INT,
    fkhospital INT,
    FOREIGN KEY (fk_localLixeira_idLocal) REFERENCES local_lixeira(idLocal),
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
    leitura_idLeitura INT UNIQUE,
    
    FOREIGN KEY (leitura_idLeitura)
        REFERENCES leitura(idLeitura)
);

-- INSERTS INICIAIS
INSERT INTO tipoResiduo (descricao) VALUES
('A - Infectante'),
('B - Químico'),
('C - Radioativo'),
('D - Comum'),
('E - Perfurocortante');

-- =============================================
-- HOSPITAIS (2 empresas)
-- =============================================
INSERT INTO hospital (nome, cnpj, email, codigo_ativacao, telefone) VALUES
('Hospital São Lucas', '12.345.678/0001-90', 'contato@saolucas.com.br', 'HSL-2024-ABC123', '(11) 3456-7890'),
('Santa Casa de Misericórdia', '98.765.432/0001-10', 'adm@santacasa.org.br', 'SCM-2024-XYZ987', '(21) 2345-6789');

-- =============================================
-- USUÁRIOS (3 por hospital = 6 usuários)
-- =============================================
-- Hospital São Lucas (idhospital = 1)
INSERT INTO usuario (nome, email, senha, fkhospital) VALUES
('BOB Suporte', 'bob.suporte@gmail.com', 'BOBOBOBO', 1),
('Carlos Almeida', 'carlos.almeida@saolucas.com.br', 'senha123', 1),
('Mariana Souza', 'mariana.souza@saolucas.com.br', 'senha123', 1),
('Roberto Lima', 'roberto.lima@saolucas.com.br', 'senha123', 1);

-- Santa Casa (idhospital = 2)
INSERT INTO usuario (nome, email, senha, fkhospital) VALUES
('Fernanda Oliveira', 'fernanda.oliveira@santacasa.org.br', 'senha456', 2),
('Ricardo Santos', 'ricardo.santos@santacasa.org.br', 'senha456', 2),
('Juliana Costa', 'juliana.costa@santacasa.org.br', 'senha456', 2);

-- =============================================
-- ENDEREÇOS (1 por hospital)
-- =============================================
INSERT INTO endereco (rua, complemento, bairro, CEP, fkhospital) VALUES
('Rua Dr. Luiz Migliano', 'Bloco A - Térreo', 'Jardim América', '01415-001', 1),
('Rua Santa Clara', 'Prédio Principal - Ala Sul', 'Centro', '20021-010', 2);

-- =============================================
-- LOCAIS (1 por hospital = 2 locais subterrâneos)
-- =============================================
INSERT INTO local_lixeira (descricao, fkhospital) VALUES
('Central de Resíduos - Subsolo', 1),
('Central de Resíduos - Subsolo', 2);

-- =============================================
-- SENSORES (2 por tipo de resíduo = 10 sensores HC-SR04)
-- =============================================
INSERT INTO sensor (modelo, statusSensor) VALUES
('HC-SR04', 'Ativo'),
('HC-SR04', 'Ativo'),
('HC-SR04', 'Ativo'),
('HC-SR04', 'Ativo'),
('HC-SR04', 'Ativo'),
('HC-SR04', 'Ativo'),
('HC-SR04', 'Ativo'),
('HC-SR04', 'Ativo'),
('HC-SR04', 'Ativo'),
('HC-SR04', 'Manutenção');

-- =============================================
-- LIXEIRAS (10 lixeiras - 2 por tipo de resíduo)
-- =============================================
-- Tipo A - Infectante (idTipo = 1)
INSERT INTO lixeira (identificacao, capacidadeMaxima, fk_localLixeira_idLocal, fk_tipoResiduo_idTipo, fk_sensor_idSensor, fkhospital) VALUES
('LIX-INF-001', 50.0, 1, 1, 1, 1),
('LIX-INF-002', 50.0, 2, 1, 2, 2);

-- Tipo B - Químico (idTipo = 2)
INSERT INTO lixeira (identificacao, capacidadeMaxima, fk_localLixeira_idLocal, fk_tipoResiduo_idTipo, fk_sensor_idSensor, fkhospital) VALUES
('LIX-QUI-003', 30.0, 1, 2, 3, 1),
('LIX-QUI-004', 30.0, 2, 2, 4, 2);

-- Tipo C - Radioativo (idTipo = 3)
INSERT INTO lixeira (identificacao, capacidadeMaxima, fk_localLixeira_idLocal, fk_tipoResiduo_idTipo, fk_sensor_idSensor, fkhospital) VALUES
('LIX-RAD-005', 20.0, 1, 3, 5, 1),
('LIX-RAD-006', 20.0, 2, 3, 6, 2);

-- Tipo D - Comum (idTipo = 4)
INSERT INTO lixeira (identificacao, capacidadeMaxima, fk_localLixeira_idLocal, fk_tipoResiduo_idTipo, fk_sensor_idSensor, fkhospital) VALUES
('LIX-COM-007', 100.0, 1, 4, 7, 1),
('LIX-COM-008', 100.0, 2, 4, 8, 2);

-- Tipo E - Perfurocortante (idTipo = 5)
INSERT INTO lixeira (identificacao, capacidadeMaxima, fk_localLixeira_idLocal, fk_tipoResiduo_idTipo, fk_sensor_idSensor, fkhospital) VALUES
('LIX-PERF-009', 30.0, 1, 5, 9, 1),
('LIX-PERF-010', 30.0, 2, 5, 10, 2);

-- =============================================
-- LEITURAS (10 leituras por sensor = 100 leituras)
-- Simulando 1 dia de coleta a cada 30 min (06:00 às 10:30)
-- =============================================

-- Sensor 1 - Hospital São Lucas - LIX-INF-001
INSERT INTO leitura (volumeAtual, percentualPreenchido, dataHora, fk_sensor_idSensor) VALUES
(8.5, 17.00, '2024-01-15 06:00:00', 1),
(12.3, 24.60, '2024-01-15 06:30:00', 1),
(15.7, 31.40, '2024-01-15 07:00:00', 1),
(18.2, 36.40, '2024-01-15 07:30:00', 1),
(22.9, 45.80, '2024-01-15 08:00:00', 1),
(27.4, 54.80, '2024-01-15 08:30:00', 1),
(31.8, 63.60, '2024-01-15 09:00:00', 1),
(36.1, 72.20, '2024-01-15 09:30:00', 1),
(40.5, 81.00, '2024-01-15 10:00:00', 1),
(300.2, 90.40, '2024-01-15 10:30:00', 1);

-- Sensor 2 - Santa Casa - LIX-INF-002
INSERT INTO leitura (volumeAtual, percentualPreenchido, dataHora, fk_sensor_idSensor) VALUES
(5.0, 10.00, '2024-01-15 06:00:00', 2),
(6.8, 13.60, '2024-01-15 06:30:00', 2),
(9.2, 18.40, '2024-01-15 07:00:00', 2),
(11.5, 23.00, '2024-01-15 07:30:00', 2),
(14.3, 28.60, '2024-01-15 08:00:00', 2),
(17.6, 35.20, '2024-01-15 08:30:00', 2),
(20.1, 40.20, '2024-01-15 09:00:00', 2),
(24.7, 49.40, '2024-01-15 09:30:00', 2),
(28.9, 57.80, '2024-01-15 10:00:00', 2),
(90.2, 66.40, '2024-01-15 10:30:00', 2);

-- Sensor 3 - Hospital São Lucas - LIX-QUI-003
INSERT INTO leitura (volumeAtual, percentualPreenchido, dataHora, fk_sensor_idSensor) VALUES
(2.1, 7.00, '2024-01-15 06:00:00', 3),
(3.4, 11.33, '2024-01-15 06:30:00', 3),
(4.8, 16.00, '2024-01-15 07:00:00', 3),
(6.2, 20.67, '2024-01-15 07:30:00', 3),
(7.5, 25.00, '2024-01-15 08:00:00', 3),
(9.1, 30.33, '2024-01-15 08:30:00', 3),
(10.8, 36.00, '2024-01-15 09:00:00', 3),
(12.4, 41.33, '2024-01-15 09:30:00', 3),
(14.1, 47.00, '2024-01-15 10:00:00', 3),
(230.2, 54.00, '2024-01-15 10:30:00', 3);

-- Sensor 4 - Santa Casa - LIX-QUI-004
INSERT INTO leitura (volumeAtual, percentualPreenchido, dataHora, fk_sensor_idSensor) VALUES
(1.5, 5.00, '2024-01-15 06:00:00', 4),
(3.0, 10.00, '2024-01-15 06:30:00', 4),
(4.2, 14.00, '2024-01-15 07:00:00', 4),
(5.7, 19.00, '2024-01-15 07:30:00', 4),
(7.0, 23.33, '2024-01-15 08:00:00', 4),
(8.8, 29.33, '2024-01-15 08:30:00', 4),
(10.5, 35.00, '2024-01-15 09:00:00', 4),
(12.3, 41.00, '2024-01-15 09:30:00', 4),
(13.9, 46.33, '2024-01-15 10:00:00', 4),
(150.8, 52.67, '2024-01-15 10:30:00', 4);

-- Sensor 5 - Hospital São Lucas - LIX-RAD-005
INSERT INTO leitura (volumeAtual, percentualPreenchido, dataHora, fk_sensor_idSensor) VALUES
(1.2, 6.00, '2024-01-15 06:00:00', 5),
(2.4, 12.00, '2024-01-15 06:30:00', 5),
(3.6, 18.00, '2024-01-15 07:00:00', 5),
(4.8, 24.00, '2024-01-15 07:30:00', 5),
(6.0, 30.00, '2024-01-15 08:00:00', 5),
(7.2, 36.00, '2024-01-15 08:30:00', 5),
(8.4, 42.00, '2024-01-15 09:00:00', 5),
(9.6, 48.00, '2024-01-15 09:30:00', 5),
(10.8, 54.00, '2024-01-15 10:00:00', 5),
(12.0, 60.00, '2024-01-15 10:30:00', 5);

-- Sensor 6 - Santa Casa - LIX-RAD-006
INSERT INTO leitura (volumeAtual, percentualPreenchido, dataHora, fk_sensor_idSensor) VALUES
(0.8, 4.00, '2024-01-15 06:00:00', 6),
(1.6, 8.00, '2024-01-15 06:30:00', 6),
(2.5, 12.50, '2024-01-15 07:00:00', 6),
(3.4, 17.00, '2024-01-15 07:30:00', 6),
(4.2, 21.00, '2024-01-15 08:00:00', 6),
(5.1, 25.50, '2024-01-15 08:30:00', 6),
(6.0, 30.00, '2024-01-15 09:00:00', 6),
(6.9, 34.50, '2024-01-15 09:30:00', 6),
(7.8, 39.00, '2024-01-15 10:00:00', 6),
(8.7, 43.50, '2024-01-15 10:30:00', 6);

-- Sensor 7 - Hospital São Lucas - LIX-COM-007
INSERT INTO leitura (volumeAtual, percentualPreenchido, dataHora, fk_sensor_idSensor) VALUES
(12.0, 12.00, '2024-01-15 06:00:00', 7),
(18.5, 18.50, '2024-01-15 06:30:00', 7),
(24.3, 24.30, '2024-01-15 07:00:00', 7),
(30.7, 30.70, '2024-01-15 07:30:00', 7),
(37.2, 37.20, '2024-01-15 08:00:00', 7),
(44.8, 44.80, '2024-01-15 08:30:00', 7),
(51.3, 51.30, '2024-01-15 09:00:00', 7),
(58.9, 58.90, '2024-01-15 09:30:00', 7),
(65.4, 65.40, '2024-01-15 10:00:00', 7),
(320.1, 72.10, '2024-01-15 10:30:00', 7);

-- Sensor 8 - Santa Casa - LIX-COM-008
INSERT INTO leitura (volumeAtual, percentualPreenchido, dataHora, fk_sensor_idSensor) VALUES
(8.5, 8.50, '2024-01-15 06:00:00', 8),
(14.2, 14.20, '2024-01-15 06:30:00', 8),
(19.8, 19.80, '2024-01-15 07:00:00', 8),
(25.4, 25.40, '2024-01-15 07:30:00', 8),
(31.6, 31.60, '2024-01-15 08:00:00', 8),
(38.9, 38.90, '2024-01-15 08:30:00', 8),
(45.2, 45.20, '2024-01-15 09:00:00', 8),
(52.7, 52.70, '2024-01-15 09:30:00', 8),
(61.3, 61.30, '2024-01-15 10:00:00', 8),
(380.8, 69.80, '2024-01-15 10:30:00', 8);

-- Sensor 9 - Hospital São Lucas - LIX-PERF-009
INSERT INTO leitura (volumeAtual, percentualPreenchido, dataHora, fk_sensor_idSensor) VALUES
(4.2, 14.00, '2024-01-15 06:00:00', 9),
(6.8, 22.67, '2024-01-15 06:30:00', 9),
(9.5, 31.67, '2024-01-15 07:00:00', 9),
(12.3, 41.00, '2024-01-15 07:30:00', 9),
(15.7, 52.33, '2024-01-15 08:00:00', 9),
(18.4, 61.33, '2024-01-15 08:30:00', 9),
(21.8, 72.67, '2024-01-15 09:00:00', 9),
(24.5, 81.67, '2024-01-15 09:30:00', 9),
(27.1, 90.33, '2024-01-15 10:00:00', 9),
(290.2, 97.33, '2024-01-15 10:30:00', 9);

-- Sensor 10 - Santa Casa - LIX-PERF-010 (em manutenção)
INSERT INTO leitura (volumeAtual, percentualPreenchido, dataHora, fk_sensor_idSensor) VALUES
(3.5, 11.67, '2024-01-14 06:00:00', 10),
(5.2, 17.33, '2024-01-14 06:30:00', 10),
(7.1, 23.67, '2024-01-14 07:00:00', 10),
(9.4, 31.33, '2024-01-14 07:30:00', 10),
(11.8, 39.33, '2024-01-14 08:00:00', 10),
(14.2, 47.33, '2024-01-14 08:30:00', 10),
(16.7, 55.67, '2024-01-14 09:00:00', 10),
(190.3, 64.33, '2024-01-14 09:30:00', 10);

CREATE VIEW vw_geralVolumes AS
SELECT l.identificacao AS nome_lixeira,
    t.descricao AS tipo_residuo,
    le.volumeAtual AS volume_atual,
    ROUND(((400 - le.volumeAtual) / 400) * 100, 2) AS volume_percentual,
    le.dataHora AS ultima_medicao
FROM lixeira l
JOIN tipoResiduo t
    ON l.fk_tipoResiduo_idTipo = t.idTipo
JOIN leitura le
    ON l.fk_sensor_idSensor = le.fk_sensor_idSensor
WHERE le.idLeitura = (
    SELECT idLeitura FROM leitura le2
    WHERE le2.fk_sensor_idSensor = l.fk_sensor_idSensor
    ORDER BY le2.dataHora DESC
    LIMIT 1
)
ORDER BY l.identificacao ASC;
