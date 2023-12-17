

-- showing continent with the highest death count per population

select continent, max(cast(total_deaths as int)) AS TotalDeathCount

from PortfolioProject..CovidDeaths
where continent is not null
group by continent
order by TotalDEathCount desc