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

5) Todos os dados das internações em seus respectivos quartos, calculando o total da internação a partir do valor de diária do quarto e o número de dias entre a entrada e a alta.

```
SELECT internacao.* , quarto.*, tipo_quarto.nr_valor AS valor_quarto,
       DATEDIFF(internacao.dt_alta, internacao.dt_procedimento) as dias_internado,
       DATEDIFF(internacao.dt_alta, internacao.dt_procedimento) * tipo_quarto.nr_valor as valor_total
FROM internacao
INNER JOIN quarto ON internacao.cd_quarto = quarto.cd_quarto
INNER JOIN tipo_quarto ON quarto.cd_tipo_quarto = tipo_quarto.cd_tipo_quarto;
```

6) Data, procedimento e número de quarto de internações em quartos do tipo “apartamento”.

```
SELECT i.cd_internacao, i.dt_procedimento, i.desc_procedimentos, q.nr_quarto
FROM internacao i
INNER JOIN quarto q ON q.cd_quarto = i.cd_quarto
WHERE q.cd_tipo_quarto = 1;
```

7) Nome do paciente, data da consulta e especialidade de todas as consultas em que os pacientes eram menores de 18 anos na data da consulta e cuja especialidade não seja “pediatria”, ordenando por data de realização da consulta.

```
SELECT p.nm_paciente, c.dt_consulta, e.nm_especialidade
FROM consulta c
JOIN paciente p ON c.cd_paciente = p.cd_paciente
JOIN especialidade e ON c.cd_especialidade = e.cd_especialidade
WHERE DATEDIFF(CURDATE(), p.dt_nascimento) / 365.25 < 18
AND e.nm_especialidade != 'Pediatria'
ORDER BY c.dt_consulta;
```

8) Nome do paciente, nome do médico, data da internação e procedimentos das internações realizadas por médicos da especialidade “gastroenterologia”, que tenham acontecido em “enfermaria”.
```
SELECT p.nm_paciente, m.nm_medico, i.dt_procedimento, i.desc_procedimentos
FROM internacao i
JOIN paciente p ON i.cd_paciente = p.cd_paciente
JOIN medico m ON i.cd_medico = m.cd_medico
WHERE m.cd_especialidade = 3 AND i.desc_procedimentos LIKE '%enfermaria%';
```

9) Os nomes dos médicos, seus CRMs e a quantidade de consultas que cada um realizou.

```
SELECT m.nm_medico, m.nr_crm, COUNT(c.cd_medico) AS quantidade_de_consultas
FROM medico m
LEFT JOIN consulta c ON m.cd_medico = c.cd_medico
GROUP BY m.nm_medico, m.nr_crm;
```

* 10) Todos os médicos que tenham "Gabriel" no nome. 

```
select * from medico where nm_medico like '%Gabriel%';
```

11) Os nomes, CREs e número de internações de enfermeiros que participaram de mais de uma internação.

```
SELECT e.nm_enfermeiroo AS Nome_Enfermeiro, e.nr_cre AS CRE, COUNT(ei.cd_internacao) AS Numero_Internacoes
FROM enfermeiro e
JOIN enfermeiro_internacao ei ON e.cd_enfermeiro = ei.cd_enfermeiro
GROUP BY e.nm_enfermeiroo, e.nr_cre
HAVING COUNT(ei.cd_internacao) > 1;
```
