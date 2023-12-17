-- shows what percentage of population got covid
SELECT
    location,
    date,
    total_cases,
    total_deaths,
    population,
    CASE
        WHEN TRY_CONVERT(float, population) = 0 THEN NULL  -- handle division by zero
        WHEN TRY_CONVERT(float, total_deaths) = 0 THEN 0     -- handle division by zero
        ELSE (TRY_CONVERT(float, total_deaths) / TRY_CONVERT(float, population)) * 100
    END AS death_percentage
FROM
    PortfolioProject..CovidDeaths
WHERE
    location LIKE '%iran%'
ORDER BY
    location,
    date;


