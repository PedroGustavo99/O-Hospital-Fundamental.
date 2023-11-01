	drop database if exists hospital;
	create database if not exists hospital;

	USE hospital;

	create table if not exists tipo_quarto (
		cd_tipo_quarto int (11) auto_increment primary key,
		nr_valor float (10,2) not null,
		descr_quarto varchar (100) not null
	);

	insert into tipo_quarto (nr_valor, descr_quarto)
	values ('700.00', 'quarto duplo');
	insert into tipo_quarto (nr_valor, descr_quarto)
	values ('850.00', 'enfermaria');
	insert into tipo_quarto (nr_valor, descr_quarto)
	values ('500.00', 'apartamento');

	create table if not exists quarto (
		cd_quarto int auto_increment primary key,
		nr_quarto float (10,2) not null,
		cd_tipo_quarto int (11) not null,
		foreign key(cd_tipo_quarto) references tipo_quarto (cd_tipo_quarto) on delete cascade on update cascade 
	);
    insert into quarto(nr_quarto, cd_tipo_quarto) values
    (2, 1),
    (3, 2),
    (4, 3),
	(5, 3),
	(10, 1);

	create table if not exists enfermeiro (
		cd_enfermeiro int auto_increment primary key,
		nm_enfermeiroo varchar(20) not null,
		nr_cpf varchar (14) unique not null,
		nr_cre varchar (14) unique not null
	);

	insert into enfermeiro(nm_enfermeiroo, nr_cpf, nr_cre) values
	('Stephanie Sousa', 74851574, '415879'),
	('Josué Armandes', 58749617, '254109'),
	('Angelo Domingues', 78032145, '012478'),
	('Bruna de Araujo', 10479547, '960124'),
	('Angelo Domingues', 87459612, '784169'),
	('Joaquim Afonso', 20147896, '894175'),
	('Priscila de Almeida', 12047953, '784196'),
	('Douglas Silva', 2143608, '254987'),
	('Pedro Augusto', 74198569, '120478'),
	('Angelina do Anjos', 88742514, '251369');

	create table if not exists convenio (
		cd_convenio int auto_increment primary key,
		nm_convenio varchar (20) not null,
		nr_cnpj varchar (18) unique not null,
		desc_tempo_carencia varchar(20) not null
	);

	insert into convenio (nm_convenio, nr_cnpj, desc_tempo_carencia)
	values ('tecnolab', '22898745000196', '96 dias');
	insert into convenio (nm_convenio, nr_cnpj, desc_tempo_carencia)
	values ('santa helena', '36598745000196', '24 dias');
	insert into convenio (nm_convenio, nr_cnpj, desc_tempo_carencia)
	values ('mais saude', '86342119000133', '6 dias');
	insert into convenio (nm_convenio, nr_cnpj, desc_tempo_carencia)
	values ('viva mais', '88852364000169', '150 dias');

	create table if not exists endereco_paciente (
		cd_endereco_paciente int auto_increment primary key,
		nm_rua varchar (50) not null,
		nr_cep varchar (15) not null,
		nm_bairro varchar (30) not null,
		nm_cidade varchar (15) not null,
		nm_estado varchar (10) not null
	);

	insert into endereco_paciente (nm_rua, nr_cep, nm_bairro, nm_cidade, nm_estado) values
	('Rua dos Pinheiros', '04556-789', 'Bela Vista', 'São Paulo', 'SP'),
	('Avenida Paulista', '01234-567', 'Ipiranga', 'São Paulo', 'SP'),
	('Rua das Rosas', '09876-543', 'Vila Madalena', 'São Paulo', 'SP'),
	('Avenida São João', '07890-123', 'Liberdade', 'São Paulo', 'SP'),
	('Rua das Acácias', '06543-210', 'Perdizes', 'São Paulo', 'SP'),
	('Alameda Santos', '03456-789', 'Itaim Bibi', 'São Paulo', 'SP'),
	('Rua Augusta', '05567-890', 'Pinheiros', 'São Paulo', 'SP'),
	('Avenida Brasil', '06789-123', 'Vila Yara', 'Osasco', 'SP'),
	('Rua da Paz', '07654-321', 'Paraíso', 'São Paulo', 'SP'),
	('Avenida Rebouças', '04567-890', 'Butantã', 'São Paulo', 'SP'),
	('Rua das Flores', '07678-123', 'Cidade Nova', 'Belo Horizonte', 'MG'),
	('Avenida da Liberdade', '12345-678', 'Centro', 'Rio de Janeiro', 'RJ'),
	('Rua dos Ipês', '45678-901', 'Vila Industrial', 'Campinas', 'SP'),
	('Avenida das Palmeiras', '34567-890', 'Centro', 'Salvador', 'BA'),
	('Rua dos Girassóis', '67890-123', 'Jardim das Acácias', 'Porto Alegre', 'RS');

	create table if not exists paciente (
		cd_paciente int auto_increment primary key,
		nm_paciente varchar (100) not null,
		dt_nascimento date not null,
		nr_cpf varchar (100) not null,
		nr_rg varchar (100) not null,
		nm_email varchar(200) not null,
		nr_telefone varchar (20) not null,
		cd_convenio int not null,
		cd_endereco_paciente int not null,
		foreign key (cd_convenio) references convenio (cd_convenio) on delete cascade on update cascade, 
		foreign key (cd_endereco_paciente) references endereco_paciente (cd_endereco_paciente) on delete cascade on update cascade 
	); 	

	insert into paciente(nm_paciente, dt_nascimento, nr_cpf, nr_rg, nm_email, nr_telefone, cd_convenio, cd_endereco_paciente) values
	('João da Silva', '1990-05-15', '123.456.789-00', '4567890', 'joao.silva@email.com', '(11) 1234-5678', 1, 1),
	('Maria Santos', '1985-08-20', '987.654.321-00', '7890123', 'maria.santos@email.com', '(21) 9876-5432', 2, 2),
	('Pedro Oliveira', '1995-03-10', '111.222.333-00', '1234567', 'pedro.oliveira@email.com', '(31) 1111-2222', 3, 3),
	('Ana Pereira', '1980-12-05', '333.444.555-00', '2345678', 'ana.pereira@email.com', '(41) 3333-4444', 4, 4),
	('Carlos Alves', '1992-07-25', '555.666.777-00', '3456789', 'carlos.alves@email.com', '(51) 5555-6666', 1, 5),
	('Larissa Vieira', '1988-06-18', '444.555.666-00', '4567890', 'larissa.vieira@email.com', '(15) 1234-5678', 2, 6),
	('Eduardo Pereira', '1993-09-22', '777.888.999-00', '5678901', 'eduardo.pereira@email.com', '(17) 9876-5432', 3, 7),
	('Fernanda Carvalho', '1996-02-12', '222.333.444-00', '6789012', 'fernanda.carvalho@email.com', '(19) 1111-2222', 4, 8),
	('Rafael Gomes', '1984-11-30', '999.000.111-00', '7890123', 'rafael.gomes@email.com', '(14) 3333-4444', 1, 9),
	('Aline Barbosa', '1991-07-04', '888.999.000-00', '8901234', 'aline.barbosa@email.com', '(23) 5555-6666', 2, 10),
	('Marcos Rodrigues', '1986-04-27', '111.222.333-00', '9012345', 'marcos.rodrigues@email.com', '(32) 1234-5678', 3, 11),
	('Camila Almeida', '1997-01-14', '666.777.888-00', '0123456', 'camila.almeida@email.com', '(13) 9876-5432', 4, 12),
	('Gustavo Santos', '1983-03-08', '555.666.777-00', '1234567', 'gustavo.santos@email.com', '(22) 1111-2222', 3, 13),
	('Laura Souza', '1989-08-02', '222.333.444-00', '2345678', 'laura.souza@email.com', '(45) 3333-4444', 1, 14),
	('Ricardo Lima', '1994-05-25', '777.888.999-00', '3456789', 'ricardo.lima@email.com', '(27) 5555-6666', 3, 15);

	create table if not exists receita (
		cd_receita int auto_increment primary key,
		nm_receita varchar (100) not null,
		qtd_medicamento int not null,
		desc_uso_medicamento varchar (200) not null
	);

	insert into receita(nm_receita, qtd_medicamento,desc_uso_medicamento) values
	('Roacutan, Pycnogenol', '2', 'Tomar um comprimido de roacutan uma vez ao dia. Tomar um comprimido de Pycnogenol uma vez ao dia'),
	('Omeprazol e Ibuprofeno', '2', 'Tomar 1 vez ao dia de manhã, durante 4 semanas. Tomar 1 comprimido de ibuprofene a cada 4 horas.'),
	('Dipirona 1g', '1', 'Tomar um comprimido a cada 6 horas. Não tomar mais de 4 comprimidos no dia'),
	('Omeprazol, Dipirona', '2', 'Tomar 1 comprimido de omeprazol uma vez ao dia de manhã, durante 4 semanas. Tomar um comprimido de dipirona a cada 6 horas. Não tomar mais de 4 comprimidos no dia'),
	('Dipirona, Ibuprofeno, Seki Xarope ', '3', 'Tomar um comprimido de dipirona a cada 6 horas. Não tomar mais de 4 comprimidos no dia, Tomar 1 comprimido de ibuprofene a cada 4 horas. Tomar o xarope se houver tosse'),
	('Diurético, Metoprolol', '2', 'Tomar 2 comprimidos de Diurético de 50 mg + 50 mg por dia. Tomar o Metoprolol uma vez ao dia'),
	('Omeprazol e Ibuprofeno', '2', 'Tomar 1 vez ao dia de manhã, durante 4 semanas. Tomar 1 comprimido de ibuprofene a cada 4 horas.'),
	('Roacutan, Pycnogenol', '2', 'Tomar um comprimido de roacutan uma vez ao dia. Tomar um comprimido de Pycnogenol uma vez ao dia'),
	('Omeprazol, Dipirona', '2', 'Tomar 1 comprimido de omeprazol uma vez ao dia de manhã, durante 4 semanas. Tomar um comprimido de dipirona a cada 6 horas. Não tomar mais de 4 comprimidos no dia'),
	('Dipirona, Ibuprofeno', '2', 'Tomar um comprimido de dipirona a cada 6 horas. Não tomar mais de 4 comprimidos no dia, Tomar 1 comprimido de ibuprofene a cada 4 horas. Tomar o xarope se houver tosse'),
	('Diurético, Metoprolol', '2', 'Tomar 2 comprimidos de Diurético de 50 mg + 50 mg por dia. Tomar o Metoprolol uma vez ao dia');

	create table if not exists cargo (
		cd_cargo int auto_increment primary key,
		nm_cargo varchar (50)
	);
	insert into cargo(nm_cargo)
	values ('generalistas');
	insert into cargo(nm_cargo)
	values ('especialistas ');
	insert into cargo(nm_cargo)
	values ('residentes ');

	create table if not exists especialidade (
		cd_especialidade int auto_increment primary key,
		nm_especialidade varchar (50) not null
	);
	insert into especialidade(nm_especialidade)
	values ('Pediatria');
	insert into especialidade(nm_especialidade)
	values ('Clinico Geral');
	insert into especialidade(nm_especialidade)
	values ('Gastrenterologia ');
	insert into especialidade(nm_especialidade)
	values ('Dermatologia ');
	insert into especialidade(nm_especialidade)
	values ('Cardiologista ');
	insert into especialidade(nm_especialidade)
	values ('Oftalmologista ');
	insert into especialidade(nm_especialidade)
	values ('Alergista ');

	create table if not exists endereco_medico (
		cd_endereco_medico int auto_increment primary key,
		nm_rua varchar (50) not null,
		nr_cep varchar (10) not null,
		nm_bairro varchar (15) not null,
		nm_cidade varchar (15) not null,
		nm_estado varchar (10) not null
	);

	insert into endereco_medico (nm_rua, nr_cep, nm_bairro, nm_cidade, nm_estado) values
	('Rua Cardeal Arcoverde', '05407-003', 'Pinheiros', 'São Paulo', 'São Paulo'),
	('R. Jesuíno Arruda', '04532-082', 'Itaim Bibi', 'São Paulo', 'São Paulo'),
	('Rua Romano Schiesari', '05018-020', 'Sumaré', 'São Paulo', 'São Paulo'),
	('R. da Consolação', '3325-3181', 'Cerqueira César', 'São Paulo', 'São Paulo'),
	('R. São Joaquim', '01508-001', 'Liberdade', 'São Paulo', 'São Paulo'),
	('R. Batataes', '01423-010', 'Jardim Paulista', 'São Paulo', 'São Paulo'),
	('R. Abílio Soares', '04005-001', 'Paraíso', 'São Paulo', 'São Paulo'),
	('R. Alvarenga', '05509-001', 'Butatã', 'São Paulo', 'São Paulo'),
	('R. Gago Coutinho', '02577-020', 'Vila Yara', 'Osasco', 'São Paulo'),
	('R. Froben', '05315-010', 'Vila Leopoldina', 'São Paulo', 'São Paulo');


	create table if not exists medico (
		cd_medico int auto_increment primary key,
		nr_telefone varchar (20) not null,
		nr_crm varchar (50) not null,
		nr_cpf varchar (100) not null,
		dt_nascimento date not null,
		nm_medico varchar (100) not null,
		cd_cargo int not null,
		cd_especialidade int not null,
		cd_endereco_medico int not null,
		foreign key(cd_cargo) references cargo (cd_cargo) on delete cascade on update cascade ,
		foreign key(cd_especialidade) references especialidade (cd_especialidade) on delete cascade on update cascade ,
		foreign key(cd_endereco_medico) references endereco_medico (cd_endereco_medico) on delete cascade on update cascade 
	);

	insert into medico(nr_telefone, nr_crm, nr_cpf, dt_nascimento, nm_medico, cd_cargo, cd_especialidade, cd_endereco_medico) values
	('11 4563988', '55886', '52369875466', '1990-08-20', 'Dra. Isabella Silva', 1, 2, 1),
	('11 4563988', '55886', '52369875466', '1990-08-20', 'Dr. Lucas Santos', 2, 6, 2),
	('11 4563988', '55886', '52369875466', '1990-08-20', 'Dra. Sofia Pereira', 3, 4, 3),
	('11 4563988', '55886', '52369875466', '1990-08-20', 'Dr. Mateus Oliveira', 2, 2, 4),
	('11 4563988', '55886', '52369875466', '1990-08-20', 'Dra. Julia Souza', 1, 2, 5),
	('11 4563988', '55886', '52369875466', '1990-08-20', 'Dra. João Silva', 3, 4, 6),
	('11 4563988', '55886', '52369875466', '1990-08-20', 'Dr. Gabriel Costa', 1, 5, 7),
	('11 4563988', '55886', '52369875466', '1990-08-20', 'Dra. Valentina Ferreira', 2, 2, 8),
	('11 4563988', '55886', '52369875466', '1990-08-20', 'Dr. Miguel Alves', 2, 2, 8),
	('11 4563988', '55886', '52369875466', '1990-08-20', 'Dr. Enzo Lima', 1, 2, 8);

	create table if not exists cargo_medico (
		cd_cargo_medico int auto_increment primary key,
		cd_cargo int(11) not null,
		cd_medico int(11) not null,
		foreign key (cd_cargo) references cargo (cd_cargo) on delete cascade on update cascade ,
		foreign key (cd_medico) references medico (cd_medico) on delete cascade on update cascade 
	);

	create table if not exists medico_especialidade (
		cd_medico_especialidade int auto_increment primary key,
		cd_medico int(11) not null,
		cd_especialidade int(11) not null,
		foreign key (cd_medico) references medico (cd_medico) on delete cascade on update cascade ,
		foreign key (cd_especialidade) references especialidade (cd_especialidade) on delete cascade on update cascade 
	);

	create table if not exists consulta (
		cd_consulta int auto_increment primary key,
		vlr_consulta varchar (10) not null,
		cd_medico int not null,
		dt_consulta date not null,
		cd_paciente int not null,
		cd_convenio int ,
		cd_especialidade int,
		hr_consulta time not null,
		descr_especialidade varchar (100) not null,
		foreign key(cd_medico) references medico (cd_medico) on delete cascade on update cascade ,
		foreign key(cd_paciente) references paciente (cd_paciente) on delete cascade on update cascade,
		foreign key(cd_convenio) references convenio (cd_convenio) on delete cascade on update cascade,
		foreign key(cd_especialidade) references especialidade (cd_especialidade) on delete cascade on update cascade
	);
	insert into consulta(dt_consulta, hr_consulta, vlr_consulta, cd_convenio, cd_medico, cd_paciente, descr_especialidade) values
	('2015-01-01', '13:40:00', '200.00', 3, 10, 5, 4),
	('2017-08-29', '08:00:00', '150.00', 4, 7, 13, 3),
	('2015-10-03', '12:30:00', '200.00', 1, 9, 4, 2),
	('2018-02-10', '09:30:00', '230.00', 1, 7, 12, 3),
	('2018-02-10', '11:00:00', '200.00', 4, 4, 11, 5),
	('2020-01-30', '18:00:00', '250.00', 1, 9, 4, 2),
	('2021-06-13', '15:30:00', '200.00', null, 7, 1, 3),
	('2022-01-01', '14:30:00', '200.00', null, 10, 3, 4),
	('2018-07-14', '08:30:00', '250.00', null, 7, 14, 3),
	('2019-05-08', '18:00:00', '250.00', null, 6, 14, 2),
	('2019-11-16', '08:45:00', '250.00', 4, 4, 13, 5),
	('2016-12-07', '15:00:00', '200.00', 4, 9, 11, 2),
	('2018-11-12', '09:30:00', '250.00', 3, 7, 5, 3),
	('2021-02-20', '12:15:00', '250.00', null, 10, 3, 4),
	('2021-02-20', '12:15:00', '250.00', null, 10, 3, 4),
	('2021-02-20', '12:15:00', '250.00', 1, 10, 2, 6),
	('2017-08-22', '14:15:00', '200.00', 1, 1, 6, 6),
	('2022-01-01', '08:45:00', '200.00', 2, 2, 7, 7),
	('2019-02-15', '17:00:00', '250.00', null, 8, 8, 1),
	('2021-11-29', '11:20:00', '200.00', null, 5, 9, 6);

	create table if not exists internacao (
		cd_internacao int auto_increment primary key,
		dt_procedimento date not null,
		cd_paciente int not null,
		cd_medico int not null,
		cd_quarto int not null,
		dt_alta date not null,
		dt_previsao_alta date not null,
		desc_procedimentos varchar (100) not null,
		foreign key(cd_paciente) references paciente (cd_paciente),
		foreign key(cd_medico) references medico (cd_medico) on delete cascade on update cascade,
		foreign key(cd_quarto) references quarto (cd_quarto) on delete cascade on update cascade
	);

	insert into internacao(dt_procedimento, dt_previsao_alta, dt_alta, desc_procedimentos, cd_paciente, cd_medico, cd_quarto) values
	('2015-01-01', '2015-01-15', '2015-01-15', 'O paciente foi internado em 01 de janeiro de 2015, para realizar uma cirurgia de apêndice.', 8, 5, 2),
	('2020-05-21', '2020-05-29', '2020-05-25', 'A paciente foi internada em 21 de maio de 2020, devido a uma fratura na perna esquerda', 1, 10, 3),
	('2016-08-18', '2016-08-30', '2016-08-26', 'O paciente foi internado em 18 de agosto de 2016, para uma cirurgia cardíaca. ', 8, 5, 2),
	('2018-07-02', '2018-07-10', '2018-07-15', 'A paciente foi internada em 10 de julho de 2018, devido a um agravamento da asma.', 15, 3, 1),
	('2022-01-01', '2022-01-05', '2022-01-04', 'O paciente foi internado em 5 de maio de 2022, para uma cirurgia de catarata.', 1, 6, 3),
	('2019-02-22', '2019-02-27', '2019-02-27', 'A paciente foi internada em 20 de abril de 2019, para tratamento de diabetes. ', 7, 9, 1),
	('2020-03-14', '2020-03-20', '2020-03-19', 'O paciente foi internado em 14 de março de 2014, para uma cirurgia de substituição de quadril', 13, 8,2);

	create table if not exists enfermeiro_internacao (
		cd_internacao_enfermeiro int auto_increment primary key,
		cd_internacao int(11) not null,
		cd_enfermeiro int(11) not null,
		foreign key (cd_internacao) references internacao (cd_internacao) on delete cascade on update cascade ,
		foreign key (cd_enfermeiro) references enfermeiro (cd_enfermeiro) on delete cascade on update cascade 
	);