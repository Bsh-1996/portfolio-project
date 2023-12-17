
--looking total population vs vaccinations


select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum (cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea -- order by something in partition by accually plus the previous amount to the new

join PortfolioProject..CovidVaccinations vac
	 on dea.location = vac.location
	 and dea.date = vac.date
where dea.continent is not null 
order by 2,3

--use cte
with popvsvac (continent, location, date, population, new_vaccinations,RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum (cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea -- order by something in partition by accually plus the previous amount to the new

join PortfolioProject..CovidVaccinations vac
	 on dea.location = vac.location
	 and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)

--select * from popvsvac

select *,(cast(RollingPeopleVaccinated as float)/ cast(population as float)) * 100
from popvsvac


-- temp table -- this query has some problem because of date table in temp is not datetime value(i should first )
drop table if exists #PercentagePopulationVaccinated
create Table #PercentagePopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
Date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)
insert into #PercentagePopulationVaccinated
select dea.continent, dea.location,  TRY_CONVERT(datetime, dea.date, 120) AS Date, dea.population, vac.new_vaccinations
, sum (cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea -- order by something in partition by accually plus the previous amount to the new

join PortfolioProject..CovidVaccinations vac
	 on dea.location = vac.location
	 and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

select *, (RollingPeopleVaccinated/population) * 100
from #PercentagePopulationVaccinated




-- creating view to store data for later visualizations

create view PercentagePopulationVaccinated as
select dea.continent, dea.location,  TRY_CONVERT(datetime, dea.date, 120) AS Date, dea.population, vac.new_vaccinations
, sum (cast(vac.new_vaccinations as int)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea -- order by something in partition by accually plus the previous amount to the new

join PortfolioProject..CovidVaccinations vac
	 on dea.location = vac.location
	 and dea.date = vac.date
where dea.continent is not null 
--order by 2,3













