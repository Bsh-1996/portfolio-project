SELECT
    location,
    date,
    total_cases,
    total_deaths,
    CASE
        WHEN TRY_CONVERT(float, total_cases) = 0 THEN NULL  -- handle division by zero
        ELSE (TRY_CONVERT(float, total_deaths) / TRY_CONVERT(float, total_cases)) * 100
    END AS death_rate
FROM
    PortfolioProject..CovidDeaths
where location like '%Iran%'
ORDER BY
    location,
    date;
	 