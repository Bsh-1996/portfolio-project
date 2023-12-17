

-- global numbers


select date, sum(TRY_CONVERT(int, new_cases)) as total_cases, sum(cast(new_deaths as int)) as total_deaths,
sum(cast(new_deaths as int)) / sum(TRY_CONVERT(int, new_cases)) * 100 as DeathPercentage
from PortfolioProject..CovidDeaths
where continent is not null
group by date
order by 1,2




 

