----------------------- busca atraves de uma função ----------

CREATE FUNCTION fEventoAntigo (@Valor Varchar(20))
RETURNS TABLE AS
RETURN(
    SELECT TOP 1
        E.Descricao AS 'Evento',
        S.Nome      AS 'Sala',
        COUNT(EP.IDPessoa) AS 'Qtd Pessoas',
        Convert(Varchar(10), E.DtHrInicio, 103) AS 'Data de Início',
        Convert(Varchar(10), E.DtHrInicio, 108) AS 'Hora Início'
    FROM Evento E
    INNER JOIN Sala S
        ON S.IDSala = E.IDSala
    INNER JOIN EventoPessoa EP
        ON EP.IDEvento = E.IDEvento
    WHERE E.Descricao LIKE @Valor+'%'
    GROUP BY E.Descricao, S.Nome, E.DtHrInicio
    ORDER BY E.DtHrInicio
)
 
SELECT * FROM fEventoAntigo('Aula')
