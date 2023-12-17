-- highest infection 
-- looking at countries with highest infection rate
-- compared to population

select location, population, max(total_cases) as HighestInfectionCount,
	max(cast(total_cases as float)/ cast(population as float)) * 100 as percentPopulationInfected

from PortfolioProject..CovidDeaths
group by location, population
order by percentPopulationInfected desc
