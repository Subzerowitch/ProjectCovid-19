SELECT *
FROM [ProjectCovid-19].dbo.covid_deaths
WHERE continent IS NOT NULL
ORDER BY 3,4

SELECT location,date, total_cases,new_cases, total_deaths, population
FROM [ProjectCovid-19].dbo.covid_deaths
ORDER BY 1,2

-- Total cases vs Total deaths
-- Shows the probability of dying if you catch covid in your country

SELECT location,date, total_cases,total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM [ProjectCovid-19].dbo.covid_deaths
WHERE location like 'Ukraine'
ORDER BY 1,2

-- Total Cases vs Population
-- Percentage of population that have got covid-19

SELECT Location, date, Population, total_cases,  (CAST(total_cases AS DECIMAL) / CAST(population AS DECIMAL))*100 AS PercentagePopulInfected
FROM [ProjectCovid-19].dbo.covid_deaths
WHERE location like 'Ukraine'
ORDER BY 1,2

-- Countries with highest infection rate compared to population

SELECT Location, Population, MAX(total_cases) AS HighestInfCount,  MAX((CAST(total_cases AS DECIMAL) / CAST(population AS DECIMAL)))*100 AS PercentPopulationInf
FROM [ProjectCovid-19].dbo.covid_deaths
-- WHERE location like 'Ukraine'
GROUP BY Location, Population
ORDER BY PercentPopulationInf DESC

-- Countries with the highest death count per population
-- Ukraine is at the 17th place

SELECT Location, MAX(CAST(total_deaths as int)) AS TotalDeathsCount 
FROM [ProjectCovid-19].dbo.covid_deaths
WHERE continent IS NOT NULL
GROUP BY Location
ORDER BY TotalDeathsCount DESC

-- By continent
-- Continents with highest death count

SELECT continent, MAX(CAST(total_deaths as int)) AS TotalDeathsCount 
FROM [ProjectCovid-19].dbo.covid_deaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathsCount DESC


-- Global numbers 

 SELECT  SUM(new_cases) AS NewCases, SUM(new_deaths) AS NewDeaths, SUM(new_deaths) / SUM(new_cases)*100 AS DeathPercentage
 FROM [ProjectCovid-19].dbo.covid_deaths
 WHERE continent IS NOT NULL
 --GROUP BY date
 ORDER BY 1,2


-- Total Population vs Vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (PARTITION BY  dea.location ORDER BY dea.location, 
dea.date) AS RollingPeopleVaccinated
FROM [ProjectCovid-19].dbo.covid_deaths dea
JOIN [ProjectCovid-19].dbo.covid_vaccinations vac 
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3


-- CTE

WITH PopVsVac (Continent, location, date, population, New_vaccinations, RollingPeopleVaccinated)
AS(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (PARTITION BY  dea.location ORDER BY dea.location, 
dea.date) AS RollingPeopleVaccinated
FROM [ProjectCovid-19].dbo.covid_deaths dea
JOIN [ProjectCovid-19].dbo.covid_vaccinations vac 
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3
)
SELECT *, CAST(RollingPeopleVaccinated AS DECIMAL) / CAST(Population AS DECIMAL)*100
FROM PopVsVac


-- Temp Table

DROP TABLE IF EXISTS #PercentOfPopulVaccinated
CREATE TABLE #PercentOfPopulVaccinated
(
Continent nvarchar(200),
Location nvarchar(200),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)
INSERT INTO #PercentOfPopulVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (PARTITION BY  dea.location ORDER BY dea.location, 
dea.date) AS RollingPeopleVaccinated
FROM [ProjectCovid-19].dbo.covid_deaths dea
JOIN [ProjectCovid-19].dbo.covid_vaccinations vac 
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3
SELECT *, CAST(RollingPeopleVaccinated AS DECIMAL) / CAST(Population AS DECIMAL)*100
FROM #PercentOfPopulVaccinated


-- Create view to store data for further visualizations

CREATE VIEW PercentOfPopulVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(vac.new_vaccinations) OVER (PARTITION BY  dea.location ORDER BY dea.location, 
dea.date) AS RollingPeopleVaccinated
FROM [ProjectCovid-19].dbo.covid_deaths dea
JOIN [ProjectCovid-19].dbo.covid_vaccinations vac 
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2,3

SELECT *
FROM PercentOfPopulVaccinated