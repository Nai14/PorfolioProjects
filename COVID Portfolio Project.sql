

Select *
From PortfolioProject..CovidDeaths
Where continent is not null
order by 3, 4

--SElECT * 
--FROM PortfolioProject..CovidVaccinations
--ORDER BY 3,4

--Select data that we are going to be using

Select Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
Where continent is not null
ORDER BY 1,2

-- Looking at Total Cases vs Total Deaths

Select Location, date, total_cases, total_deaths
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2

-- Altering the data type of two different columns from nvarchar to bigint

ALTER TABLE CovidDeaths
ALTER COLUMN total_cases float;

ALTER TABLE CovidDeaths
ALTER COLUMN total_deaths float;


Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2

-- Working out the death rate by dividing the total deaths by total cases and then multiplying by 100 to get the percentage
-- The percentage reveals your chance of dying

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as 'Death Percentage'
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2


Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as 'Death Percentage'
FROM PortfolioProject..CovidDeaths
Where Location like '%kingdom%'
and continent is not null
ORDER BY 1,2


Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as 'Death Percentage'
FROM PortfolioProject..CovidDeaths
Where Location like '%zealand%'
and continent is not null
ORDER BY 1,2


-- Looking at Total Cases vs Total Deaths
-- Shows the likelihood of dying if you contract Covid in your country 

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as 'Death Percentage'
FROM PortfolioProject..CovidDeaths
Where Location like '%kingdom%'
and continent is not null
ORDER BY 1,2

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as 'Death Percentage'
FROM PortfolioProject..CovidDeaths
Where Location like '%zealand%'
and continent is not null
ORDER BY 1,2


Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as 'Death Percentage'
FROM PortfolioProject..CovidDeaths
Where Location like '%states%'
and continent is not null
ORDER BY 1,2


Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as 'Death Percentage'
FROM PortfolioProject..CovidDeaths
Where Location like '%singapore%'
and continent is not null
ORDER BY 1,2

-- Looking at Total Cases vs Total Deaths
-- Shows the likelihood of dying if you contract Covid in your country 

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as 'Death Percentage'
FROM PortfolioProject..CovidDeaths
Where Location like '%kingdom%'
and continent is not null
ORDER BY 1,2

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as 'Death Percentage'
FROM PortfolioProject..CovidDeaths
Where Location like '%zealand%'
and continent is not null
ORDER BY 1,2


Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as 'Death Percentage'
FROM PortfolioProject..CovidDeaths
Where Location like '%states%'
and continent is not null
ORDER BY 1,2


Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as 'Death Percentage'
FROM PortfolioProject..CovidDeaths
Where Location like '%denmark%'
and continent is not null
ORDER BY 1,2



-- Looking at the Total Cases vs Population
-- Shows what percentage of the population has gotten Covid

Select Location, date, Population, total_cases, (total_cases/population)*100 as 'Covid Case Percentage'
FROM PortfolioProject..CovidDeaths
Where Location like '%kingdom%'
and continent is not null
ORDER BY 1,2


-- Looking at Countries with Highest Infection Rate compared to Population

Select Location, Population, MAX(total_cases) AS 'Highest Infection Count',MAX(total_cases/population)*100 as 'Percent Population Percentage'
FROM PortfolioProject..CovidDeaths
--Where Location like '%kingdom%'
Where continent is not null
GROUP By Location, population
ORDER BY 1,2



Select Location, Population, MAX(total_cases) AS 'Highest Infection Count',MAX(total_cases/population)*100 as 'Percent Population Percentage'
FROM PortfolioProject..CovidDeaths
--Where Location like '%kingdom%'
Where continent is not null
GROUP By Location, population
ORDER BY [Percent Population Percentage] desc



-- Showing countries with the highest death count per population

Select Location, MAX(Total_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--Where Location like '%kingdom%'
Where continent is not null
GROUP By Location
ORDER BY TotalDeathCount desc


-- Breaking things down by continent
-- This is a more accurate way of displaying the data

Select location, MAX(Total_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--Where Location like '%kingdom%'
Where continent is null
GROUP By location
ORDER BY TotalDeathCount desc


-- Showing the continents with the highest death count per population

Select continent, MAX(Total_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--Where Location like '%kingdom%'
Where continent is not null
GROUP By continent
ORDER BY TotalDeathCount desc


-- Global Numbers

SET ARITHABORT OFF;
SET ANSI_WARNINGS OFF;
Select date, SUM(new_cases) as totalcases, SUM(new_deaths) as totaldeaths, SUM(new_deaths)/SUM
  (new_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
--Where Location like '%kingdom%'
Where continent is not null
Group by date
ORDER BY 1,2


-- Total Cases

SET ARITHABORT OFF;
SET ANSI_WARNINGS OFF;
Select SUM(new_cases) as totalcases, SUM(new_deaths) as totaldeaths, SUM(new_deaths)/SUM
  (new_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
--Where Location like '%kingdom%'
Where continent is not null
--and new_cases is not null
--Group by date
ORDER BY 1,2


-- Calculating the value of New Cases by by New Deaths
SET ARITHABORT OFF;
SET ANSI_WARNINGS OFF;
Select Location, date, new_cases, new_deaths,(new_cases/new_deaths) as NewCaseByDeath
FROM PortfolioProject..CovidDeaths
Where continent is not null
ORDER BY 1,2


-- Looking at total population vs vaccinations

With PopsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.Location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
   On dea.location = vac.location
   and dea.date = vac.date
where dea.continent is not null

)

Select*, (RollingPeopleVaccinated/Population)*100 as percentagevaccinated
From PopsVac


-- TEMP TABLE
DROP TABLE IF EXISTS #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)


INSERT INTO #PercentPopulationVaccinated


Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.Location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
   On dea.location = vac.location
   and dea.date = vac.date
--where dea.continent is not null



Select*, (RollingPeopleVaccinated/Population)*100 as percentagevaccinated
From #PercentPopulationVaccinated


-- Creating view to store data for later visualisations

Create View PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 
,SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.Location, dea.date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
   On dea.location = vac.location
   and dea.date = vac.date
where dea.continent is not null


Select *
From PercentPopulationVaccinated

