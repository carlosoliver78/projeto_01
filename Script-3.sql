SELECT 
*
FROM CovidDeaths cd

/*
02_ Faça uma tabela com uma coluna de total de casos e outra com total
total de mortes por país.
*/

SELECT 
sum(new_cases)
FROM CovidDeaths cd 
WHERE iso_code NOT LIKE 'OWID%'

SELECT 
sum(new_deaths)
FROM CovidDeaths cd 
WHERE iso_code NOT LIKE 'OWID%'

--03_ Mostre a probabilidade de morrer se contrair covid em cada país.

SELECT 
location,
MAX(population),
ROUND(sum(new_deaths)/MAX(population),15 ) as percent_death,
population
FROM CovidDeaths cd 
GROUP BY location 

--04_ Faça uma tabela com uma coluna de total de casos  e outra com total população por país

SELECT 
sum(new_cases)
FROM CovidDeaths cd 
WHERE iso_code NOT LIKE 'OWID%'
GROUP BY location 

SELECT 
sum(population)
FROM CovidDeaths cd 
WHERE iso_code NOT LIKE 'OWID%'
GROUP BY location 

-- 05_ Mostre a probabilidade de se infectar com Covid por país.

SELECT 
location,
sum(new_cases),
max(population),
round(sum(new_cases)/max(population),4)*100 as percent_infection
from CovidDeaths cd 
group by location

SELECT  
	location,
	MAX(1000*new_cases/population) AS taxa_infeccao_por_mil
FROM CovidDeaths cd 
GROUP BY location

-- 06_Quais são os países com maior taxa de infecção?

SELECT 
	location,
	MAX(1000*new_cases/population) AS taxa_infeccao_por_mil
FROM CovidDeaths cd 
GROUP BY location
ORDER BY taxa_infeccao_por_mil DESC

-- 07_Quais são os países com maior taxa de morte?

SELECT
	*,
	total_mortes/total_casos AS taxa_mortalidade
	FROM( 
	SELECT 
		location,
		SUM(new_cases) AS total_casos,
		SUM(new_deaths) AS total_mortes
	FROM CovidDeaths cd 
	GROUP BY location
)
ORDER BY taxa_mortalidade DESC

-- 08_Mostre os continentes com a maior taxa de morte.

CREATE VIEW vw_total_continente AS
SELECT 
	continent,
	SUM(new_cases) AS total_casos,
	SUM(new_deaths) AS total_mortes
FROM CovidDeaths cd 
GROUP BY continent

SELECT * FROM vw_total_continente vtc

SELECT 
	continent,
	SUM(new_cases) AS total_casos,
	SUM(new_deaths) AS total_mortes
FROM CovidDeaths cd 
GROUP BY continent

/*
 09_População Total vs Vacinações: mostre a porcentagem da população 
 que recebeu pelo menos uma vacina contra a Covid.
 a. Importante mostrar acumulado de vacina por data e localização.
 */


SELECT * FROM covidDeaths

SELECT * FROM covidVaccinations

SELECT
	cv.location,
	cv.date,
	cv.people_vaccinated,
	cd.population,
	100*cv.people_vaccinated/cd.population AS taxa_vacinada
FROM covidVaccinations AS cv
INNER JOIN covidDeaths AS cd
ON (
	cv.iso_code = cd.iso_code
	AND cv.date = cd.date
)


