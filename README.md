# O-Hospital-Fundamental.
Utilizando a modelagem de dados para um pequeno hospital local que busca desenvolver um novo sistema que atenda melhor às suas necessidades.

Analise a seguinte descrição e extraia dela os requisitos para o banco de dados:
O hospital necessita de um sistema para sua área clínica que ajude a controlar consultas realizadas. Os médicos podem ser generalistas, especialistas ou residentes e têm seus dados pessoais cadastrados em planilhas digitais. Cada médico pode ter uma ou mais especialidades, que podem ser pediatria, clínica geral, gastroenterologia e dermatologia. Alguns registros antigos ainda estão em formulário de papel, mas será necessário incluir esses dados no novo sistema.

Os pacientes também precisam de cadastro, contendo dados pessoais (nome, data de nascimento, endereço, telefone e e-mail), documentos (CPF e RG) e convênio. Para cada convênio, são registrados nome, CNPJ e tempo de carência.

As consultas também têm sido registradas em planilhas, com data e hora de realização, médico responsável, paciente, valor da consulta ou nome do convênio, com o número da carteira. Também é necessário indicar na consulta qual a especialidade buscada pelo paciente.

Deseja-se ainda informatizar a receita do médico, de maneira que, no encerramento da consulta, ele possa registrar os medicamentos receitados, a quantidade e as instruções de uso. A partir disso, espera-se que o sistema imprima um relatório da receita ao paciente ou permita sua visualização via internet.

# PARTE 1

<img src = "o_hospital.jpeg">

No hospital, as internações têm sido registradas por meio de formulários eletrônicos que gravam os dados em arquivos. 

Para cada internação, são anotadas a data de entrada, a data prevista de alta e a data efetiva de alta, além da descrição textual dos procedimentos a serem realizados. 

As internações precisam ser vinculadas a quartos, com a numeração e o tipo. 

Cada tipo de quarto tem sua descrição e o seu valor diário (a princípio, o hospital trabalha com apartamentos, quartos duplos e enfermaria).

Também é necessário controlar quais profissionais de enfermaria estarão responsáveis por acompanhar o paciente durante sua internação. Para cada enfermeiro(a), é necessário nome, CPF e registro no conselho de enfermagem (CRE).

A internação, obviamente, é vinculada a um paciente – que pode se internar mais de uma vez no hospital – e a um único médico responsável.

 <img src = "o_hospital_fundamental_ER.png">

# Parte 2 - Diagrama Entidade Relacionamento

Desse modelo já devemos gerar a etapa lógica da nossa modelagem!

<img src = "o_hospital_fundamental_DER.png">

# PARTE 3 - Alimentando o banco de dados

<p>Crie scripts de povoamento das tabelas desenvolvidas na atividade anterior
Observe as seguintes atividades:<p>
 <ul>
<li>Inclua ao menos dez médicos de diferentes especialidades.</li>

<li>Ao menos sete especialidades (considere a afirmação de que “entre as especialidades há pediatria, clínica geral, gastrenterologia e dermatologia”).</li>

<li>Inclua ao menos 15 pacientes.</li>

<li>Registre 20 consultas de diferentes pacientes e diferentes médicos (alguns pacientes realizam mais que uma consulta). As consultas devem ter ocorrido entre 01/01/2015 e 01/01/2022. Ao menos dez consultas devem ter receituário com dois ou mais medicamentos.</li>

<li>Inclua ao menos quatro convênios médicos, associe ao menos cinco pacientes e cinco consultas.</li>

<li>Criar entidade de relacionamento entre médico e especialidade. </li>

<li>Criar Entidade de Relacionamento entre internação e enfermeiro. </li>

<li>Arrumar a chave estrangeira do relacionamento entre convênio e médico.</li>

<li>Criar entidade entre internação e enfermeiro.</li>

<li>Colocar chaves estrangeira dentro da internação (Chaves Médico e Paciente).</li>

<li>Registre ao menos sete internações. Pelo menos dois pacientes devem ter se internado mais de uma vez. Ao menos três quartos devem ser cadastrados. As internações devem ter ocorrido entre 01/01/2015 e 01/01/2022.</li>

<li>Considerando que “a princípio o hospital trabalha com apartamentos, quartos duplos e enfermaria”, inclua ao menos esses três tipos com valores diferentes.</li>

<li>Inclua dados de dez profissionais de enfermaria. Associe cada internação a ao menos dois enfermeiros.</li>

<li>Os dados de tipo de quarto, convênio e especialidade são essenciais para a operação do sistema e, portanto, devem ser povoados assim que o sistema for instalado.</li>
</ul>

# PARTE 4 - A Ordem do Alterar. 

Pensando no banco que já foi criado para o Projeto do Hospital, realize algumas alterações nas tabelas e nos dados usando comandos de atualização e exclusão:

Crie um script que adicione uma coluna “em_atividade” para os médicos, indicando se ele ainda está atuando no hospital ou não. 

Crie um script para atualizar ao menos dois médicos como inativos e os demais em atividade.

<img src = "parte4.png">

<img src = "parte4-2.png">

# PARTE 5 - Consultas
<p> Crie um script e nele inclua consultas que retornem: </p>

1) Todos os dados e o valor médio das consultas do ano de 2020 e das que foram feitas sob convênio.

```
select *, avg(vlr_consulta) as valor_medio_consultas
FROM consulta 
where year(dt_consulta) = 2020 and cd_consulta is not null
group by(dt_consulta), cd_consulta;
```
2) Todos os dados das internações que tiveram data de alta maior que a data prevista para a alta.

```
select * from internacao
where dt_alta > dt_previsao_alta;
```

3) Receituário completo da primeira consulta registrada com receituário associado.
```
select * from consulta 
inner join receita on consulta.cd_consulta = receita.cd_consulta
inner join paciente on paciente.cd_paciente = consulta.cd_paciente
order by receita.cd_receita limit 1;
```

4) Todos os dados da consulta de maior valor e também da de menor valor (ambas as consultas não foram realizadas sob convênio).

```
(select *
 from consulta
 where cd_convenio is null
 order by vlr_consulta desc
 limit 1)
 
 UNION
 
 (select *
 from consulta
 where cd_convenio is null
 order by vlr_consulta asc
 limit 1);
```

* Todos os dados das internações em seus respectivos quartos, calculando o total da internação a partir do valor de diária do quarto e o número de dias entre a entrada e a alta.

```
select *, DATEDIFF(data_efet_alta, data_entrada) dias_internado, tipo_quarto.valor_diario, DATEDIFF(data_efet_alta, data_entrada) * tipo_quarto.valor_diario valor_total from internacao inner join quarto on internacao.quarto_id = quarto.id_quarto inner join tipo_quarto on quarto.tipo_id = tipo_quarto.id_tipo;
```

* Data, procedimento e número de quarto de internações em quartos do tipo “apartamento”.

```
select i.id_internacao, i.data_entrada, i.desc_procedimentos, q.numero from internacao i inner join quarto q 
on q.id_quarto = i.quarto_id where q.tipo_id = 1; 
```

* Nome do paciente, data da consulta e especialidade de todas as consultas em que os pacientes eram menores de 18 anos na data da consulta e cuja especialidade não seja “pediatria”, ordenando por data de realização da consulta.

```
select p.nome_paciente, c.data_consulta, e.nome_especialidade from consulta c inner join paciente p 
on p.id_paciente = c.paciente_id inner join especialidade e 
on e.id_especialidade = c.especialidade_id 
where c.especialidade_id <> 1 and year(c.data_consulta) - year(p.dt_nasc_paciente) < 19 and year(c.data_consulta) - year(p.dt_nasc_paciente) > 0 
order by c.data_consulta ;
```

* Nome do paciente, nome do médico, data da internação e procedimentos das internações realizadas por médicos da especialidade “gastroenterologia”, que tenham acontecido em “enfermaria”.

```
select p.nome_paciente, m.nome_medico, i.data_entrada, i.desc_procedimentos, q.id_quarto
from internacao i
inner join medico m 
on m.id_medico = i.medico_id
inner join paciente p
on p.id_paciente = i.paciente_id
inner join quarto q
on q.id_quarto = i.quarto_id
where q.tipo_id = 3 and m.especialidade_id = 3;
```

* Os nomes dos médicos, seus CRMs e a quantidade de consultas que cada um realizou.

```
select m.nome_medico, m.crm, count(c.medico_id) as 'Qntd de consultas' from medico m inner join consulta c 
on c.medico_id = m.id_medico group by c.medico_id;
```

* Todos os médicos que tenham "Gabriel" no nome.

```
select * from medico where nome_medico like '%Gabriel%';
```

* Os nomes, CREs e número de internações de enfermeiros que participaram de mais de uma internação.

```
select enf.nome_enfermeiro, enf.cre, COUNT(p.enfermeiro_id) as Participacao from enfermeiro enf
inner join plantao p on p.enfermeiro_id = enf.id_enfermeiro group by enf.id_enfermeiro having Participacao > 1;
```
