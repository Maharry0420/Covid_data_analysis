-- to see table for 1st data table
SELECT *
FROM master.dbo.covid_data


-- to see table for 2nd data table
SELECT *
FROM master.dbo.covid_data_2

-- to see the 6 list from a data table
Select location, date, total_cases, new_cases, total_deaths, population
From master.dbo.covid_data
Order by 1,2

-- looking at total cases vs total deaths as percentage
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From master.dbo.covid_data
Order by 1,2

-- looking at total cases vs total deaths as percentage in USA
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From master.dbo.covid_data
where location like '%states%'
Order by 1,2

--looking at total cases vs population in the USA to show the percentage caught covid.
Select location, date,population, total_cases, (total_cases/population)*100 as PercentPopulation
From master.dbo.covid_data
where location like '%states%'
Order by 1,2

--Looking at countries with highest infection rate compared to population
Select location, population, MAX(total_cases)as Highest_Infection_Count, MAX((total_cases/population))*100 as PercentPopulation
From master.dbo.covid_data
GROUP BY location, Population
Order by PercentPopulation DESC

--showing countries with with the highest death rate compared to population percentage
Select location, population, MAX(cast(total_deaths as int))as Highest_Infection_Count, MAX((total_deaths/population))*100 as DeathPercentage
From master.dbo.covid_data
GROUP BY location, Population
Order by DeathPercentage DESC

--showing countries with the hight death dates per population
Select location, MAX(cast(total_deaths as int))as Total_Death_count
From master.dbo.covid_data
WHERE continent is NOT NULL
GROUP BY location
Order by Total_Death_count DESC

--showing continent with the hight death dates per population
Select location, MAX(cast(total_deaths as int))as Total_Death_count
From master.dbo.covid_data
WHERE continent is NULL and location NOT LIKE '%income%'
GROUP BY location
Order by Total_Death_count DESC

--showing the global numbers per day and new cases and total death
Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as Death_Percentage
From master.dbo.covid_data
WHERE continent is NULL and location NOT LIKE '%income%' and new_deaths != 0
GROUP BY date
Order by 1

-- total death percentage 
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as Death_Percentage
From master.dbo.covid_data
WHERE continent is NULL and location NOT LIKE '%income%' and new_deaths != 0
Order by 1

-- to get the 2nd table
Select *
From master.dbo.covid_data_2

-- to join both tables
Select *
From master.dbo.covid_data dea
Join master.dbo.covid_data_2 vac
	ON dea.location = vac.location and dea.date = vac.date

-- to look at total population vs Vaccination
Select dea.date, dea.continent, dea.location, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition BY dea.location order by dea.location, dea.date)
as rolling_people_vaccinated
From master.dbo.covid_data dea
Join master.dbo.covid_data_2 vac
	ON dea.location = vac.location and dea.date = vac.date
Where dea.continent IS NOT NULL
Order by 3

-- WITH CTE
With PopVSVac (continent, location, date, population,new_vaccinations, rolling_people_vaccinated)
as 
(Select dea.date, dea.continent, dea.location, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition BY dea.location order by dea.location, dea.date)
as rolling_people_vaccinated
From master.dbo.covid_data dea
Join master.dbo.covid_data_2 vac
	ON dea.location = vac.location and dea.date = vac.date
Where dea.continent IS NOT NULL)
--Order by 3)
Select *, (rolling_people_vaccinated/population)*100 as percentage
From PopVSVac
Order by percentage DESC


-- temp table
Drop table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
date datetime,
Continent varchar(255),
location varchar(255),
population numeric,
new_vaccinations numeric,
rolling_people_vaccinated numeric)
Insert Into #PercentPopulationVaccinated
Select dea.date, dea.continent, dea.location, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition BY dea.location order by dea.location, dea.date)
as rolling_people_vaccinated
From master.dbo.covid_data dea
Join master.dbo.covid_data_2 vac
	ON dea.location = vac.location and dea.date = vac.date
Where dea.continent IS NOT NULL
--Order by 3)
Select *, (rolling_people_vaccinated/population)*100 as percentage
From #PercentPopulationVaccinated
--Order by percentage DESC


-- creating sql for visuals
Create view PercentPopulationVaccinated as
Select dea.date, dea.continent, dea.location, dea.population, vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition BY dea.location order by dea.location, dea.date)
as rolling_people_vaccinated
From master.dbo.covid_data dea
Join master.dbo.covid_data_2 vac
	ON dea.location = vac.location and dea.date = vac.date
Where dea.continent IS NOT NULL
--Order by 3)
