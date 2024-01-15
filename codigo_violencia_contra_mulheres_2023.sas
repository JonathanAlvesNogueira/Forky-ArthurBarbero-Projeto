LIBNAME JONY '/home/u63480479/my_shared_file_links/u63480479';

DATA JONY.VIOLENCIA_CONTRA_MULHER;
SET WORK.LIGUE180_PRIMEIRO_SEMESTRE_2023;
RUN;

DATA BASE_ANALISE;
SET JONY.VIOLENCIA_CONTRA_MULHER;

	PAIS2 = SCAN('PA�S'n, 2, '|');

	FORMAT REGIAO $30.;
	if uf IN ('AC', 'AM', 'AP', 'PA', 'RO', 'RR', 'TO') then
    regiao = 'Norte';
  else if uf IN ('AL', 'BA', 'CE', 'MA', 'PB', 'PE', 'PI', 'RN', 'SE') then
    regiao = 'Nordeste';
  else if uf IN ('DF', 'GO', 'MT', 'MS') then
    regiao = 'Centro-Oeste';
  else if uf IN ('ES', 'MG', 'RJ', 'SP') then
    regiao = 'Sudeste';
  else if uf IN ('PR', 'RS', 'SC') then
    regiao = 'Sul';
  else
    regiao = '';

	IF sl_vitima_cadastro = 'PESSOA F�SICA' THEN TIPO_PESSOA = 'PF';
  ELSE TIPO_PESSOA = 'PJ';

  Data_Formatada = put(datepart(Data_de_cadastro), DDMMYY10.);
  ANO = YEAR(Data_Formatada);
  
RUN;

%LET NM = Den�ncia_emergencial	
		  ,TIPO_PESSOA
		  ,REGIAO
		  ,Canal_de_atendimento
		  ,Denunciante
		  ,Frequ�ncia
		  ,In�cio_das_viola��es
		  ,Rela��o_v�tima_suspeito
		  ,Faixa_et�ria_da_v�tima

;


PROC SQL;
	CREATE TABLE teste AS SELECT 
		SUM(sl_quantidade_vitimas) AS QTD_VITIMAS
		,&NM.
	FROM BASE_ANALISE
	GROUP BY &NM.
;
QUIT;
