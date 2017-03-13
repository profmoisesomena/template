# TRABALHO 01 : Título do trabalho
Trabalho desenvolvido durante a disciplina de BD

    O referido projeto poderá ser:
        a) Um novo sistema/projeto 
        b) Uma expansão de sistema/projeto previamente desenvolvido em disciplinas anteriores 
        (ex: Expansão dos módulos do sistema desenvolvidos em BD1 - incremento mínimo de 50% nos 
        requisitos/complexidade)
    
    OBS Importantes: 
        a) Os projetos/sistemas propostos serão validados pelo professor e pela turma
        b) Se possível é interessante que os novos sistemas estejam correlacionados com alguma área 
        previamente estudada pelo aluno
        c) Caso dependa de alguma instituição/parceiro externo, a base de dados e informações pertinentes 
        a esta devem ser obtidas no prazo de até 15 dias apos aprovação da proposta do trabalho 
        (caso contrário, nova proposta deverá ser apresentada a turma implicando logicamente em um prazo 
        mais curto para realização das atividades e conclusão do trabalho)
        
#Sumário

###1	COMPONENTES<br>
Edson Simões Boldrini<br>
Pedro Henrique Elias Da Cruz Costa<br>

###2	INTRODUÇÃO E MOTIVAÇAO<br>
Este documento contém a especificação do projeto do banco de dados "Controle de acesso por RFID" que tem como motivação oferecer uma maior segurança aos alunos do IFES Campus Serra. <br>
      
###3	MINI-MUNDO<br>
O IFES (Instituto Federal do Espírito Santo) campus Serra está inserindo alunos do ensino médio em suas dependências disponibilizando cursos técnicos integrados ao ensino médio para adolescentes interessados em aprenderem algo a mais do que o ensino médio normal.
Esses adolescentes são, em boa parte, menores de idade, e/ou ainda moram e/ou tem alguma dependência com seus respectivos pais ou responsáveis. Com isso, deseja-se construir um sistema para controle de entrada e saída dos alunos do ensino médio do ifes campus serra.
No portão de entrada principal será instalado um leitor de RFID e todo acesso de entrada e saída ficará registado em um log. O controle de acesso de cada aluno seria baseado no horário da sua turma, cada turma possui seus horários de entradas e saídas da parte da manhã e tarde, conforme os horários dos alunos pode não haver registro de logs de entrada ou saída.
Os alunos têm responsáveis, e, como base de um sistema automático, será disponibilizado aos responsáveis todos os logs de acesso para que, eles possam fazer o acompanhamento do acesso do aluno a instituição.
A situação do aluno no log poderia indicar, se o aluno está na instituição ou não, se ele tem faltado muitas aulas e até mesmo se o aluno se encontra em educação física ou visita técnica. <br>

###4	RASCUNHOS BÁSICOS DA INTERFACE (MOCKUPS)<br>
neste ponto a codificação não e necessária, somente as ideias de telas devem ser criadas, o princípio aqui é pensar na criação da interface para identificar possíveis informações a serem armazenadas ou descartadas <br>

Sugestão: https://balsamiq.com/products/mockups/<br>

![Alt text](https://github.com/discipbd2/topicos-trabalho/blob/master/balsamiq.png?raw=true "Title")


###5	MODELO CONCEITUAL<br>
####5.1 NOTACAO ENTIDADE RELACIONAMENTO
![Alt text](https://github.com/pedrohcosta/Topicos-Trabalho-BD2/blob/master/imagens/modelo_conceitual.jpg?raw=true "Modelo Conceitual")
    
    5.2 NOTACAO UML (Caso esteja fazendo a disciplina de Projeto)

####5.3 DECISÕES DE PROJETO
    [atributo]: [descrição da decisão]
    
    EXEMPLO:
    a) Campo endereço: em nosso projeto optamos por um campo multivalorado e composto, pois a empresa 
    pode possuir para cada departamento mais de uma localização... 
    b) justifique!

####5.3 DESCRIÇÃO DOS DADOS 
    [objeto]: [descrição do objeto]
    
    EXEMPLO:
    CLIENTE: Tabela que armazena as informações relativas ao cliente<br>
    CPF: campo que armazena o número de Cadastro de Pessoa Física para cada cliente da empresa.<br>

###6	MODELO LÓGICO<br>

![Alt text](https://github.com/pedrohcosta/Topicos-Trabalho-BD2/blob/master/imagens/modelo_logico.jpg?raw=true "Modelo Lógico")

###7	MODELO FÍSICO<br>
	
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

###8	INSERT APLICADO NAS TABELAS DO BANCO DE DADOS<br>
####8.1 DETALHAMENTO DAS INFORMAÇÕES
        Detalhamento sobre as informações e processo de obtenção ou geração dos dados.
        Referenciar todas as fontes referentes a:
        a) obtenção dos dados
        b) obtenção de códigos reutilizados
        c) fontes de estudo para desenvolvimento do projeto
        
####8.2 INCLUSÃO DO SCRIPT PARA CRIAÇÃO DE TABELAS E INSERÇÃO DOS DADOS (ARQUIVO ÚNICO COM):
        a) inclusão das instruções para criação das tabelas e estruturas de amazenamento do BD
        b) inclusão das instruções de inserção dos dados nas referidas tabelas
        c) inclusão das instruções para execução de outros procedimentos necessários

###9	TABELAS E PRINCIPAIS CONSULTAS<br>
####9.1	GERACAO DE DADOS (MÍNIMO DE 1,5 MILHÃO DE REGISTROS PARA PRINCIPAL RELAÇAO)<br>
    Data de Entrega: (Data a ser definida)
<br>
OBS: Incluir para os tópicos 9.2 e 9.3 as instruções SQL + imagens (print da tela) mostrando os resultados.<br>

####9.2	SELECT DAS TABELAS COM PRIMEIROS 10 REGISTROS INSERIDOS<br> 
    Data de Entrega: (Data a ser definida)
<br>
####9.3	SELECT DAS VISÕES COM PRIMEIROS 10 REGISTROS DA VIEW<br>
        a) Descrição da view sobre que grupos de usuários (operacional/estratégico) <br>
        e necessidade ela contempla.
        b) Descrição das permissões de acesso e usuários correlacionados (após definição <br>
        destas características)
    Data de Entrega: (Data a ser definida)
<br>
####9.4	LISTA DE CODIGOS DAS FUNÇÕES, ASSERÇOES E TRIGGERS<br>
        Detalhamento sobre funcionalidade de cada código.
        a) Objetivo
        b) Código do objeto (função/trigger/asserção)
        c) exemplo de dados para aplicação
        d) resultados em forma de tabela/imagem
<br>
####9.5	Administração do banco de dados<br>
        Descrição detalhada sobre como serão executadas no banco de dados as <br>
        seguintes atividades.
        a) Segurança e autorização de acesso:
        b) Estimativas de aquisição de recursos para armazenamento e processamento da informação
        c) Planejamento de rotinas de manutenção e monitoramento do banco
        d) Plano com frequencia de análises visando otimização de performance
<br>
####9.6	Backup do Banco de Dados<br>
        Detalhamento do backup.
        a) Tempo
        b) Tamanho
        c) Teste de restauração (backup)
        d) Tempo para restauração
        e) Teste de restauração (script sql)
        f) Tempo para restauração (script sql)
<br>
Data de Entrega: (Data a ser definida)
<br>
####9.7	APLICAÇAO DE ÍNDICES E TESTES DE PERFORMANCE<br>
    a) Lista de índices, tipos de índices com explicação de porque foram implementados
    b) Performance esperada VS Resultados obtidos
    c) Tabela de resultados comparando velocidades antes e depois da aplicação dos índices.
<br>
    Data de Entrega: (Data a ser definida)
<br>   
####9.8	ANÁLISE DOS DADOS COM ORANGE<br>    
    a) aplicação de algoritmos e interpretação dos resultados
<br>
    Data de Entrega: (Data a ser definida)
<br>
###10	ATUALIZAÇÃO DA DOCUMENTAÇÃO/ SLIDES E ENTREGA FINAL<br>
<br>
    Data de Entrega: (Data a ser definida)
<br>
###11	DIFICULDADES ENCONTRADAS PELO GRUPO<br>  
###12  FORMATACAO NO GIT: https://help.github.com/articles/basic-writing-and-formatting-syntax/
