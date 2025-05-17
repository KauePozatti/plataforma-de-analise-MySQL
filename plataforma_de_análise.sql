create database Plataforma_de_Análise;
use Plataforma_de_Análise;

set sql_safe_updates=0;

create table usuarios
(
id_usuario int auto_increment primary key,
nome varchar(255) not null,
email varchar(100) unique not null,
data_nascimento date,
perfil_risco enum('Conservador', 'Moderado', 'Agressivo'),
objetivo_financeiro text not null,
prazo_objetivo date not null
);
describe usuarios;

create table ativos
(
id_ativos int auto_increment primary key,
nome_ativo varchar(20) not null,
tipo_ativo enum('Ação','FII','CDB','Cripto','etc') not null,
ticker int not null,
categoria enum('Renda Variável','Renda Fixa','Cripto','Internacional') not null
);
describe ativos;
alter table ativos modify column ticker varchar(10) not null;
desc ativos;

create table transacoes
(
id_transacao int auto_increment primary key,
tipo_transacao enum('Compra','Venda') not null,
data_transacao datetime default current_timestamp,
quantidade int,
preco_unitario decimal(10, 2) not null,
usuario_id int,
ativos_id int,
foreign key (usuario_id) references usuarios (id_usuario),
foreign key (ativos_id) references ativos (id_ativos)
);
describe transacoes;

create table carteiras
(
id_carteira int auto_increment primary key,
quantidade_total int,
usuario_id int,
ativos_id int,
foreign key (usuario_id) references usuarios (id_usuario),
foreign key (ativos_id) references ativos (id_ativos)
);
describe carteiras;

create table historico_precos
(
id_preco int auto_increment primary key,
data_referencia date not null,
preco_fechamneto decimal(10, 2) not null,
ativos_id int,
foreign key (ativos_id) references ativos (id_ativos)
);
describe historico_precos;
alter table historico_precos change preco_fechamneto 
preco_fechamento decimal(10, 2) not null;

create table dividendos
(
id_dividendo int auto_increment primary key,
data_pagamento date not null,
valor_por_acao decimal(10, 2) not null,
ativos_id int,
foreign key (ativos_id) references ativos (id_ativos)
);
describe dividendos;

create table aportes_mensais
(
id_aporte int auto_increment primary key,
data_aporte date not null,
valor_aportado decimal(10, 2) not null,
usuario_id int,
foreign key (usuario_id) references usuarios (id_usuario)
);
describe aportes_mensais;

create table metas_financeiras
(
id_meta int auto_increment primary key,
descricao_meta text not null,
valor_necessario decimal(10, 2) not null,
data_alvo date not null,
usuario_id int,
foreign key (usuario_id) references usuarios (id_usuario)
);
describe metas_financeiras;

create table categorias_ativos
(
id_categoria int auto_increment primary key,
nome_categoria enum('Renda Variável','Renda Fixa','etc')
);

create table indicadores_economicos
(
id_indicador int auto_increment primary key,
nome_indicador enum('CDI','Selic','IPCA','etc'),
data_referencia date not null,
valor decimal(10, 2) not null
);

insert into usuarios (nome, email, data_nascimento, perfil_risco, objetivo_financeiro, prazo_objetivo) values
('Ana Souza', 'ana@email.com', '1990-05-12', 'Conservador', 'Aposentadoria tranquila', '2045-01-01'),
('Bruno Lima', 'bruno@email.com', '1985-03-20', 'Moderado', 'Comprar uma casa', '2030-06-01'),
('Carlos Torres', 'carlos@email.com', '1992-11-15', 'Agressivo', 'Ficar milionário', '2028-12-31'),
('Diana Castro', 'diana@email.com', '1995-07-07', 'Moderado', 'Viajar pelo mundo', '2035-09-10'),
('Eduardo Mendes', 'edu@email.com', '1980-02-02', 'Conservador', 'Educação dos filhos', '2038-10-05'),
('Fernanda Melo', 'fer@email.com', '1997-01-21', 'Agressivo', 'Independência financeira', '2032-01-01'),
('Gabriel Ramos', 'gabriel@email.com', '1991-09-09', 'Moderado', 'Montar um negócio', '2029-03-15');

insert into ativos (nome_ativo, tipo_ativo, ticker, categoria) values
('Petrobras PN', 'Ação', 'PETR4', 'Renda Variável'),
('Magazine Luiza', 'Ação', 'MGLU3', 'Renda Variável'),
('Tesouro IPCA+', 'CDB', 'IPCA2035', 'Renda Fixa'),
('Bitcoin', 'Cripto', 'BTC', 'Cripto'),
('Ethereum', 'Cripto', 'ETH', 'Cripto'),
('XP Inc', 'Ação', 'XPBR31', 'Internacional'),
('Tesouro Selic', 'CDB', 'SELIC2027', 'Renda Fixa');

insert into transacoes (tipo_transacao, quantidade, preco_unitario, usuario_id, ativos_id) values
('Compra', 10, 28.50, 1, 1),
('Compra', 50, 3.20, 2, 2),
('Venda', 5, 30.00, 1, 1),
('Compra', 2, 120000.00, 3, 4),
('Compra', 1, 8500.00, 4, 5),
('Compra', 10, 100.00, 5, 6),
('Compra', 5, 1000.00, 6, 3);

insert into carteiras (quantidade_total, usuario_id, ativos_id) values
(20, 1, 1),
(50, 2, 2),
(2, 3, 4),
(1, 4, 5),
(10, 5, 6),
(5, 6, 3),
(3, 7, 7);

insert into historico_precos (data_referencia, preco_fechamento, ativos_id) values
('2024-01-01', 27.90, 1),
('2024-02-01', 28.50, 1),
('2024-03-01', 29.00, 1),
('2024-04-01', 30.00, 1),
('2024-01-01', 3.00, 2),
('2024-02-01', 3.20, 2),
('2024-03-01', 3.10, 2);

insert into dividendos (data_pagamento, valor_por_acao, ativos_id) values
('2024-01-10', 0.85, 1),
('2024-02-10', 0.90, 1),
('2024-03-10', 0.95, 1),
('2024-01-15', 0.05, 2),
('2024-02-15', 0.06, 2),
('2024-03-15', 0.04, 2),
('2024-04-10', 1.00, 6);

insert into aportes_mensais (data_aporte, valor_aportado, usuario_id) values
('2024-01-05', 1000.00, 1),
('2024-02-05', 1200.00, 1),
('2024-01-07', 1500.00, 2),
('2024-02-10', 1300.00, 2),
('2024-01-12', 800.00, 3),
('2024-02-12', 1000.00, 3),
('2024-01-15', 900.00, 4);

insert into metas_financeiras (descricao_meta, valor_necessario, data_alvo, usuario_id) values
('Comprar apartamento', 300000.00, '2030-01-01', 1),
('Fundo de emergência', 20000.00, '2026-01-01', 2),
('Carro novo', 60000.00, '2027-05-01', 3),
('Viagem para Europa', 25000.00, '2025-12-20', 4),
('Abrir empresa', 100000.00, '2029-06-01', 5),
('Estudar fora', 150000.00, '2031-09-10', 6),
('Independência financeira', 2000000.00, '2040-01-01', 7);

insert into categorias_ativos (nome_categoria) values
('Renda Variável'),
('Renda Fixa'),
('Renda Fixa'),
('Renda Fixa'),
('Renda Variável'),
('Renda Variável'),
('Renda Variável');

insert into indicadores_economicos (nome_indicador, data_referencia, valor) values
('CDI', '2024-01-01', 13.15),
('Selic', '2024-01-01', 13.75),
('IPCA', '2024-01-01', 5.25),
('CDI', '2024-02-01', 13.10),
('Selic', '2024-02-01', 13.65),
('IPCA', '2024-02-01', 5.10),
('CDI', '2024-03-01', 13.00);






