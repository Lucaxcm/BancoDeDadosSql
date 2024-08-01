--SELECT 
--	IDEvento,
--	Descricao as 'Descrição Do Evento',
--	CONVERT(VARCHAR(10), DtHrInicio, 103) as 'Data Início',
--	CONVERT(VARCHAR(5), DtHrInicio, 108) as 'Hora Início',

--	CONVERT(VARCHAR(10), DtHrFim, 103) as 'Data Final',
--	CONVERT(VARCHAR(5), DtHrFim, 108) as 'Hora Final'


	
--	FROM Evento

--WHERE GETDATE() BETWEEN DtHrInicio AND DtHrFim

--UPDATE Evento
--SET 
--	DtHrInicio = '01-08-2024 13:00',
--	DtHrFim = '01-08-2024 17:00'

--WHERE IDEvento = '080Z9TPT7GFS'


SELECT 

	IDEvento,
	Descricao as 'Descrição Do Evento',
	CONVERT(VARCHAR(10), DtHrInicio, 103) as 'Data Início',
	CONVERT(VARCHAR(5), DtHrInicio, 108) as 'Hora Início',

	CONVERT(VARCHAR(10), DtHrFim, 103) as 'Data Final',
	CONVERT(VARCHAR(5), DtHrFim, 108) as 'Hora Final'

FROM Evento E
	LEFT JOIN Sala S
	ON e.IDSala = S.IDSala
