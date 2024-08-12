select codigo_produto as PRODUTO, produto as NOME_PRODUTO 
from [dbo].[tb_produto]

select sigla_estado as ESTADO, nome_estado as NOME_ESTADO from tb_estado

SELECT dbo.tb_estado.nome_estado AS ESTADO, dbo.tb_produto.produto AS PRODUTO, 
YEAR([data]) AS ANO,
       SUM(CONVERT(FLOAT, (dbo.tb_item.quantidade))) as QUANTIDADE
FROM   dbo.tb_item INNER JOIN
       dbo.tb_produto ON dbo.tb_item.codigo_produto = dbo.tb_produto.codigo_produto INNER JOIN
       dbo.tb_nota ON dbo.tb_item.numero = dbo.tb_nota.numero CROSS JOIN
       dbo.tb_cliente INNER JOIN
       dbo.tb_cidade ON dbo.tb_cliente.cidade = dbo.tb_cidade.cidade INNER JOIN
       dbo.tb_estado ON dbo.tb_cidade.sigla_estado = dbo.tb_estado.sigla_estado
	   WHERE dbo.tb_produto.codigo_produto = 2 AND dbo.tb_estado.sigla_estado = 'RJ'
	   AND YEAR([data]) = 2020
	   GROUP BY 
	   dbo.tb_estado.nome_estado, dbo.tb_produto.produto, YEAR([data])