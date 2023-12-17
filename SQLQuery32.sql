


--showing countries with highest death count  per population


select location, max(cast(total_deaths as int)) AS TotalDeathCount

from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by TotalDEathCount desc

