DECLARE @ESTE_MES INT DECLARE @ESTADO VARCHAR(2)
SET @ESTE_MES = 2
SET @ESTADO = 'SP'
SELECT VENDAS.classificacao AS CLASSIFICACAO,
       ROUND(VENDAS.VALOR_MES, 2) AS VALOR,
       ROUND((VENDAS.VALOR_MES/ TOTAL.VALOR_TOTAL) * 100, 2) AS PERCENTUAL
FROM
  (SELECT SUM(tb_item.quantidade * tb_item.preco) AS VALOR_TOTAL
   FROM tb_item
   INNER JOIN tb_nota ON tb_item.numero = tb_nota.numero
   INNER JOIN tb_cliente ON tb_nota.cpf = tb_cliente.cpf
   INNER JOIN tb_cidade ON tb_cliente.cidade = tb_cidade.cidade
   INNER JOIN tb_estado ON tb_cidade.sigla_estado = tb_estado.sigla_estado
   WHERE YEAR(tb_nota.data) = 2020
     AND MONTH(tb_nota.data) = @ESTE_MES
     AND tb_estado.sigla_estado = @ESTADO) TOTAL,

  (SELECT tb_classificacao.classificacao AS CLASSIFICACAO,
          SUM(tb_item.quantidade * tb_item.preco) AS VALOR_MES
   FROM tb_item
   INNER JOIN tb_nota ON tb_item.numero = tb_nota.numero
   INNER JOIN tb_produto ON tb_item.codigo_produto = tb_produto.codigo_produto
   INNER JOIN tb_classificacao ON tb_produto.codigo_classificacao = tb_classificacao.codigo_classificacao
   INNER JOIN tb_cliente ON tb_nota.cpf = tb_cliente.cpf
   INNER JOIN tb_cidade ON tb_cliente.cidade = tb_cidade.cidade
   INNER JOIN tb_estado ON tb_cidade.sigla_estado = tb_estado.sigla_estado
   WHERE YEAR(tb_nota.data) = 2020
     AND MONTH(tb_nota.data) = @ESTE_MES
     AND tb_estado.sigla_estado = @ESTADO
   GROUP BY tb_classificacao.classificacao) VENDAS
ORDER BY (VENDAS.VALOR_MES/ TOTAL.VALOR_TOTAL) * 100 DESC