
--TABLES FOR TABLEAU DASHBOARD
-- 1. GLOBAL STATS OF COVID-19
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From portolioproject..CovidDeaths 
where continent is not null 
order by 1,2



-- 2.TOTAL NUMBER OF DEATHS PER CONTINENT
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From portolioproject..CovidDeaths 
Where continent is null 
AND location NOT IN ('World', 'High income', 'Upper middle income', 'Lower middle income', 'Low income', 'European Union', 'Oceania', 'International')
Group by location
order by TotalDeathCount desc


-- 3.PERCENTAGE POPULATION INFECTED 
Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From portolioproject..CovidDeaths 
Group by Location, Population
order by PercentPopulationInfected desc


-- 4.PERCENTAGE DEATH PER COUNTRY
Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From portolioproject..CovidDeaths 
Group by Location, Population, date
order by PercentPopulationInfected desc