----------------- TODOS EVENTOS COM SUAS DATAS E HORARIOS ---------------------------------
SELECT
    E.IDEvento,
    E.Descricao AS "Descrição do Evento",
    CONVERT(VARCHAR(10), E.DtHrInicio, 103) AS "Data Início",
    CONVERT(VARCHAR(5), E.DtHrInicio, 108) AS "Hora Início",
    CONVERT(VARCHAR(10), E.DtHrFim, 103) AS "Data Fim",
    CONVERT(VARCHAR(5), E.DtHrFim, 108) AS "Hora Fim",
    S.Nome AS "Nome da Sala"
 FROM Evento E
 LEFT JOIN Sala S
    ON E.IDSala = S.IDSala

----------------------------- SALAS COM MAIOR CAPACIDADE ----------------------------------
SELECT TOP 3
    Nome 'Nome da Sala',
    Capacidade
FROM Sala
ORDER BY Capacidade DESC
	
------------------------------------ SOMENTE O RESPONSAVEL PELO EVENTO --------------------
SELECT  P.Nome          AS "Responsável",
        E.Descricao     AS "Descrição do Evento",
        Convert(Varchar(10), E.DtHrInicio, 103) AS "Data de Início",
        Convert(Varchar(10), E.DtHrInicio, 108) AS "Hora de Início",
        Convert(Varchar(10), E.DtHrFim, 103)    AS "Data de Fim",
        Convert(Varchar(10), E.DtHrFim, 108)    AS "Hora de Fim",
        S.Nome          AS "Nome da Sala"
FROM Evento E
 
INNER JOIN Sala S
    ON E.IDSala = S.IDSala
INNER JOIN EventoPessoa EP
    ON E.IDEvento = EP.IDEvento
INNER JOIN Pessoa P
    ON EP.IDPessoa = P.IDPessoa
 
WHERE EP.PapelEvento = 'Responsavel'

--------- Quanto tempo(Minutos) cada sala foi ou será utilizada ---------------------------
SELECT
    S.Nome AS "Nome da Sala",  
    SUM(DateDiff(MINUTE, E.DtHrInicio, E.DtHrFim)) AS "Utilização (minutos)"
 
FROM Sala S
INNER JOIN Evento E
    ON S.IDSala = E.IDSala
 
GROUP BY S.Nome

-------------- Quantidade de Eventos que Cada Pessoa Participou ---------------------------
SELECT
    P.Nome,
    COUNT(EP.IDEvento) AS Quantidade
FROM Pessoa P
LEFT JOIN EventoPessoa EP
    ON P.IDPessoa = EP.IDPessoa
GROUP BY P.Nome
ORDER BY Quantidade DESC

------------------------- Se A Sala Ultapassou sua Capacidade de Pessoas -------------------------
SELECT
    E.Descricao AS "Evento",
    S.Nome      AS "Sala",
    S.Capacidade,
    COUNT(EP.IDPessoa) AS "Quantidade Participantes",
 
CASE WHEN S.Capacidade < COUNT(EP.IDPessoa) THEN 'Ultrapassou o Limite!'
ELSE 'Limite OK' END AS "Avaliação da Capacidade"
 
FROM EventoPessoa EP
INNER JOIN Evento E
    ON EP.IDEvento = E.IDEvento
INNER JOIN Sala S
    ON S.IDSala = E.IDSala
 
GROUP BY E.Descricao, S.Nome, S.Capacidade, E.IDEvento

------------- USANDO WHERE COM NULL -------------------------
SELECT
    Nome AS 'Equipamento',
    Tipo
FROM Equipamento
 
WHERE IDSala is NULL

---------------- SUB SELECT -----------------------------------
SELECT * FROM Evento E
INNER JOIN EventoEquipamento EQ
    ON E.IDEvento = EQ.IDEvento
 
WHERE EQ.IDEquipamento IN
 
(SELECT IDEquipamento
 FROM Equipamento
 WHERE Tipo IN ('Informatica','Multimidia'))

 --------------- FAZER UMA BUSCA SOMENTE COM UMA PARTE DO TEXTO ----------------------
-- Deve terminar com "IOT" na descrição
SELECT * FROM Evento WHERE Descricao LIKE '%IOT'
 
-- Deve começar com "Aula" na descrição
SELECT * FROM Evento WHERE Descricao LIKE 'Aula%'
 
-- Palestra em qualquer lugar da descrição
SELECT * FROM Evento WHERE Descricao LIKE '%Industria%'

---------------------- USANDO VIEW -------------------------------------------------
CREATE VIEW vwVendas AS
SELECT * FROM Tabela
 
Select * From vwVendas
ORDER BY MesAno
