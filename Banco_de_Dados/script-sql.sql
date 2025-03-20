-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS agencia_viagens;
USE agencia_viagens;

-- Tabela CLIENTE
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    rg VARCHAR(20) NOT NULL,
    data_nascimento DATE NOT NULL,
    genero ENUM('Masculino', 'Feminino', 'Outro', 'Prefiro não informar'),
    estado_civil ENUM('Solteiro(a)', 'Casado(a)', 'Divorciado(a)', 'Viúvo(a)'),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_cpf CHECK (cpf REGEXP '^[0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}$')
);

-- Tabela CONTATO
CREATE TABLE contato (
    id_contato INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone_celular VARCHAR(15) NOT NULL,
    telefone_fixo VARCHAR(15),
    telefone_emergencia VARCHAR(15) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    CONSTRAINT chk_email CHECK (email REGEXP '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$')
);

-- Tabela ENDERECO
CREATE TABLE endereco (
    id_endereco INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    cep VARCHAR(9) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(100),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    CONSTRAINT chk_cep CHECK (cep REGEXP '^[0-9]{5}-[0-9]{3}$'),
    CONSTRAINT chk_estado CHECK (estado REGEXP '^[A-Z]{2}$')
);

-- Tabela USUARIO
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    ultimo_acesso DATETIME,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE CASCADE,
    CONSTRAINT chk_email_usuario CHECK (email REGEXP '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$')
);

-- Tabela DESTINO
CREATE TABLE destino (
    id_destino INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    estado VARCHAR(100),
    cidade VARCHAR(100) NOT NULL,
    descricao TEXT,
    imagem VARCHAR(255),
    ativo BOOLEAN DEFAULT TRUE
);

-- Tabela HOTEL
CREATE TABLE hotel (
    id_hotel INT AUTO_INCREMENT PRIMARY KEY,
    id_destino INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    categoria INT NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    comodidades TEXT,
    descricao TEXT,
    imagem VARCHAR(255),
    FOREIGN KEY (id_destino) REFERENCES destino(id_destino) ON DELETE CASCADE,
    CONSTRAINT chk_categoria CHECK (categoria BETWEEN 1 AND 5)
);

--