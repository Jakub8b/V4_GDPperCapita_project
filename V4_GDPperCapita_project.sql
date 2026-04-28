select 
country,
year,
gdp,
round((gdp/population)::numeric,2) as GDP_per_capita,
population
from economies
where country in ('Poland', 'Czech Republic','Slovakia', 'Hungary')
and year > '2000'
order by year;

-- O koľko sa rozdiel medzi krajinami zväčšil/zmenšil oproti minulému roku? CZ a PL
/*Pre každý rok vypočíta rozdiel GDP per capita medzi Českom a Poľskom.
Potom porovná tento rozdiel s predchádzajúcim rokom a vypočíta:

-absolútnu zmenu (o koľko € sa rozdiel zmenil)

-percentuálnu zmenu (o koľko % sa rozdiel zmenil)
*/
WITH gdp_cte AS (
    SELECT 
        country,
        year,
        ROUND((gdp::numeric / population::numeric), 2) AS gdp_per_capita
    FROM economies
    WHERE country IN ('Poland', 'Czech Republic')
      AND year > 2000
), lol AS (
    SELECT 
        a.year,
        a.country AS country_a,
        b.country AS country_b,
        a.gdp_per_capita AS gdp_pc_a,
        b.gdp_per_capita AS gdp_pc_b,
        ROUND((a.gdp_per_capita - b.gdp_per_capita)::numeric, 2) AS difference
    FROM gdp_cte a
    JOIN gdp_cte b 
        ON a.year = b.year 
       AND a.country <> b.country
), final AS (
    SELECT *
    FROM lol
    WHERE country_a = 'Czech Republic'
), notyet AS (
    SELECT *,
           LAG(difference) OVER (ORDER BY year) AS previous_year
    FROM final
)
SELECT 
    year, 
    country_a, 
    country_b, 
    gdp_pc_a, 
    gdp_pc_b,
    difference,
    previous_year,
    round((difference-previous_year)::numeric,0) as clean_diff,
    ROUND(
        (difference - previous_year) 
        / NULLIF(previous_year, 0) * 100,
        2
    ) AS percent_diff
FROM notyet
ORDER BY year;



-- SK a PL

WITH gdp_cte AS (
    SELECT 
        country,
        year,
        ROUND((gdp::numeric / population::numeric), 2) AS gdp_per_capita
    FROM economies
    WHERE country IN ('Poland', 'Slovakia')
      AND year > 2000
), lol AS (
    SELECT 
        a.year,
        a.country AS country_a,
        b.country AS country_b,
        a.gdp_per_capita AS gdp_pc_a,
        b.gdp_per_capita AS gdp_pc_b,
        ROUND((a.gdp_per_capita - b.gdp_per_capita)::numeric, 2) AS difference
    FROM gdp_cte a
    JOIN gdp_cte b 
        ON a.year = b.year 
       AND a.country <> b.country
), final AS (
    SELECT *
    FROM lol
    WHERE country_a = 'Slovakia'
), notyet AS (
    SELECT *,
           LAG(difference) OVER (ORDER BY year) AS previous_year
    FROM final
)
SELECT 
    year, 
    country_a, 
    country_b, 
    gdp_pc_a, 
    gdp_pc_b,
    difference,
    previous_year,
    round((difference-previous_year)::numeric,0) as clean_diff,
    ROUND(
        (difference - previous_year) 
        / NULLIF(previous_year, 0) * 100,
        2
    ) AS percent_diff
FROM notyet
ORDER BY year;

-- HU a PL

WITH gdp_cte AS (
    SELECT 
        country,
        year,
        ROUND((gdp::numeric / population::numeric), 2) AS gdp_per_capita
    FROM economies
    WHERE country IN ('Poland', 'Hungary')
      AND year > 2000
), lol AS (
    SELECT 
        a.year,
        a.country AS country_a,
        b.country AS country_b,
        a.gdp_per_capita AS gdp_pc_a,
        b.gdp_per_capita AS gdp_pc_b,
        ROUND((a.gdp_per_capita - b.gdp_per_capita)::numeric, 2) AS difference
    FROM gdp_cte a
    JOIN gdp_cte b 
        ON a.year = b.year 
       AND a.country <> b.country
), final AS (
    SELECT *
    FROM lol
    WHERE country_a = 'Hungary'
), notyet AS (
    SELECT *,
           LAG(difference) OVER (ORDER BY year) AS previous_year
    FROM final
)
SELECT 
    year, 
    country_a, 
    country_b, 
    gdp_pc_a, 
    gdp_pc_b,
    difference,
    previous_year,
    round((difference-previous_year)::numeric,0) as clean_diff,
    ROUND(
        (difference - previous_year) 
        / NULLIF(previous_year, 0) * 100,
        2
    ) AS percent_diff
FROM notyet
ORDER BY year;


-- CZ a HU

WITH gdp_cte AS (
    SELECT 
        country,
        year,
        ROUND((gdp::numeric / population::numeric), 2) AS gdp_per_capita
    FROM economies
    WHERE country IN ('Czech Republic', 'Hungary')
      AND year > 2000
), lol AS (
    SELECT 
        a.year,
        a.country AS country_a,
        b.country AS country_b,
        a.gdp_per_capita AS gdp_pc_a,
        b.gdp_per_capita AS gdp_pc_b,
        ROUND((a.gdp_per_capita - b.gdp_per_capita)::numeric, 2) AS difference
    FROM gdp_cte a
    JOIN gdp_cte b 
        ON a.year = b.year 
       AND a.country <> b.country
), final AS (
    SELECT *
    FROM lol
    WHERE country_a = 'Czech Republic'
), notyet AS (
    SELECT *,
           LAG(difference) OVER (ORDER BY year) AS previous_year
    FROM final
)
SELECT 
    year, 
    country_a, 
    country_b, 
    gdp_pc_a, 
    gdp_pc_b,
    difference,
    previous_year,
    round((difference-previous_year)::numeric,0) as clean_diff,
    ROUND(
        (difference - previous_year) 
        / NULLIF(previous_year, 0) * 100,
        2
    ) AS percent_diff
FROM notyet
ORDER BY year;


--CZ a SK

WITH gdp_cte AS (
    SELECT 
        country,
        year,
        ROUND((gdp::numeric / population::numeric), 2) AS gdp_per_capita
    FROM economies
    WHERE country IN ('Czech Republic', 'Slovakia')
      AND year > 2000
), lol AS (
    SELECT 
        a.year,
        a.country AS country_a,
        b.country AS country_b,
        a.gdp_per_capita AS gdp_pc_a,
        b.gdp_per_capita AS gdp_pc_b,
        ROUND((a.gdp_per_capita - b.gdp_per_capita)::numeric, 2) AS difference
    FROM gdp_cte a
    JOIN gdp_cte b 
        ON a.year = b.year 
       AND a.country <> b.country
), final AS (
    SELECT *
    FROM lol
    WHERE country_a = 'Czech Republic'
), notyet AS (
    SELECT *,
           LAG(difference) OVER (ORDER BY year) AS previous_year
    FROM final
)
SELECT 
    year, 
    country_a, 
    country_b, 
    gdp_pc_a, 
    gdp_pc_b,
    difference,
    previous_year,
    round((difference-previous_year)::numeric,0) as clean_diff,
    ROUND(
        (difference - previous_year) 
        / NULLIF(previous_year, 0) * 100,
        2
    ) AS percent_diff
FROM notyet
ORDER BY year;

-- HU a SK

WITH gdp_cte AS (
    SELECT 
        country,
        year,
        ROUND((gdp::numeric / population::numeric), 2) AS gdp_per_capita
    FROM economies
    WHERE country IN ('Hungary', 'Slovakia')
      AND year > 2000
), lol AS (
    SELECT 
        a.year,
        a.country AS country_a,
        b.country AS country_b,
        a.gdp_per_capita AS gdp_pc_a,
        b.gdp_per_capita AS gdp_pc_b,
        ROUND((a.gdp_per_capita - b.gdp_per_capita)::numeric, 2) AS difference
    FROM gdp_cte a
    JOIN gdp_cte b 
        ON a.year = b.year 
       AND a.country <> b.country
), final AS (
    SELECT *
    FROM lol
    WHERE country_a = 'Slovakia'
), notyet AS (
    SELECT *,
           LAG(difference) OVER (ORDER BY year) AS previous_year
    FROM final
)
SELECT 
    year, 
    country_a, 
    country_b, 
    gdp_pc_a, 
    gdp_pc_b,
    difference,
    previous_year,
    round((difference-previous_year)::numeric,0) as clean_diff,
    ROUND(
        (difference - previous_year) 
        / NULLIF(previous_year, 0) * 100,
        2
    ) AS percent_diff
FROM notyet
ORDER BY year;

-- UNION ALL
/*porovnáva GDP per capita medzi dvojicami krajín,
pre každý rok vypočíta rozdiel,
potom zistí ako sa tento rozdiel zmenil oproti minulému roku,
a nakoniec vypočíta percentuálnu zmenu tohto rozdielu.*/

WITH gdp_cte AS (
    SELECT 
        country,
        year,
        ROUND((gdp::numeric / population::numeric), 2) AS gdp_per_capita
    FROM economies
    WHERE country IN ('Poland', 'Czech Republic')
      AND year > 2000
), lol AS (
    SELECT 
        a.year,
        a.country AS country_a,
        b.country AS country_b,
        a.gdp_per_capita AS gdp_pc_a,
        b.gdp_per_capita AS gdp_pc_b,
        ROUND((a.gdp_per_capita - b.gdp_per_capita)::numeric, 2) AS difference
    FROM gdp_cte a
    JOIN gdp_cte b 
        ON a.year = b.year 
       AND a.country <> b.country
), final AS (
    SELECT *
    FROM lol
    WHERE country_a = 'Czech Republic'
), notyet AS (
    SELECT *,
           LAG(difference) OVER (ORDER BY year) AS previous_year
    FROM final
)
SELECT 
    year, 
    country_a, 
    country_b, 
    gdp_pc_a, 
    gdp_pc_b,
    difference,
    previous_year,
    round((difference-previous_year)::numeric,0) as clean_diff,
    ROUND(
        (difference - previous_year) 
        / NULLIF(previous_year, 0) * 100,
        2
    ) AS percent_diff
FROM notyet
ORDER BY year;
union all
WITH gdp_cte AS (
    SELECT 
        country,
        year,
        ROUND((gdp::numeric / population::numeric), 2) AS gdp_per_capita
    FROM economies
    WHERE country IN ('Poland', 'Slovakia')
      AND year > 2000
), lol AS (
    SELECT 
        a.year,
        a.country AS country_a,
        b.country AS country_b,
        a.gdp_per_capita AS gdp_pc_a,
        b.gdp_per_capita AS gdp_pc_b,
        ROUND((a.gdp_per_capita - b.gdp_per_capita)::numeric, 2) AS difference
    FROM gdp_cte a
    JOIN gdp_cte b 
        ON a.year = b.year 
       AND a.country <> b.country
), final AS (
    SELECT *
    FROM lol
    WHERE country_a = 'Slovakia'
), notyet AS (
    SELECT *,
           LAG(difference) OVER (ORDER BY year) AS previous_year
    FROM final
)
SELECT 
    year, 
    country_a, 
    country_b, 
    gdp_pc_a, 
    gdp_pc_b,
    difference,
    previous_year,
    round((difference-previous_year)::numeric,0) as clean_diff,
    ROUND(
        (difference - previous_year) 
        / NULLIF(previous_year, 0) * 100,
        2
    ) AS percent_diff
FROM notyet
ORDER BY year;
union all
WITH gdp_cte AS (
    SELECT 
        country,
        year,
        ROUND((gdp::numeric / population::numeric), 2) AS gdp_per_capita
    FROM economies
    WHERE country IN ('Poland', 'Hungary')
      AND year > 2000
), lol AS (
    SELECT 
        a.year,
        a.country AS country_a,
        b.country AS country_b,
        a.gdp_per_capita AS gdp_pc_a,
        b.gdp_per_capita AS gdp_pc_b,
        ROUND((a.gdp_per_capita - b.gdp_per_capita)::numeric, 2) AS difference
    FROM gdp_cte a
    JOIN gdp_cte b 
        ON a.year = b.year 
       AND a.country <> b.country
), final AS (
    SELECT *
    FROM lol
    WHERE country_a = 'Hungary'
), notyet AS (
    SELECT *,
           LAG(difference) OVER (ORDER BY year) AS previous_year
    FROM final
)
SELECT 
    year, 
    country_a, 
    country_b, 
    gdp_pc_a, 
    gdp_pc_b,
    difference,
    previous_year,
    round((difference-previous_year)::numeric,0) as clean_diff,
    ROUND(
        (difference - previous_year) 
        / NULLIF(previous_year, 0) * 100,
        2
    ) AS percent_diff
FROM notyet
ORDER BY year;
union all
WITH gdp_cte AS (
    SELECT 
        country,
        year,
        ROUND((gdp::numeric / population::numeric), 2) AS gdp_per_capita
    FROM economies
    WHERE country IN ('Czech Republic', 'Hungary')
      AND year > 2000
), lol AS (
    SELECT 
        a.year,
        a.country AS country_a,
        b.country AS country_b,
        a.gdp_per_capita AS gdp_pc_a,
        b.gdp_per_capita AS gdp_pc_b,
        ROUND((a.gdp_per_capita - b.gdp_per_capita)::numeric, 2) AS difference
    FROM gdp_cte a
    JOIN gdp_cte b 
        ON a.year = b.year 
       AND a.country <> b.country
), final AS (
    SELECT *
    FROM lol
    WHERE country_a = 'Czech Republic'
), notyet AS (
    SELECT *,
           LAG(difference) OVER (ORDER BY year) AS previous_year
    FROM final
)
SELECT 
    year, 
    country_a, 
    country_b, 
    gdp_pc_a, 
    gdp_pc_b,
    difference,
    previous_year,
    round((difference-previous_year)::numeric,0) as clean_diff,
    ROUND(
        (difference - previous_year) 
        / NULLIF(previous_year, 0) * 100,
        2
    ) AS percent_diff
FROM notyet
ORDER BY year;
union all
WITH gdp_cte AS (
    SELECT 
        country,
        year,
        ROUND((gdp::numeric / population::numeric), 2) AS gdp_per_capita
    FROM economies
    WHERE country IN ('Czech Republic', 'Slovakia')
      AND year > 2000
), lol AS (
    SELECT 
        a.year,
        a.country AS country_a,
        b.country AS country_b,
        a.gdp_per_capita AS gdp_pc_a,
        b.gdp_per_capita AS gdp_pc_b,
        ROUND((a.gdp_per_capita - b.gdp_per_capita)::numeric, 2) AS difference
    FROM gdp_cte a
    JOIN gdp_cte b 
        ON a.year = b.year 
       AND a.country <> b.country
), final AS (
    SELECT *
    FROM lol
    WHERE country_a = 'Czech Republic'
), notyet AS (
    SELECT *,
           LAG(difference) OVER (ORDER BY year) AS previous_year
    FROM final
)
SELECT 
    year, 
    country_a, 
    country_b, 
    gdp_pc_a, 
    gdp_pc_b,
    difference,
    previous_year,
    round((difference-previous_year)::numeric,0) as clean_diff,
    ROUND(
        (difference - previous_year) 
        / NULLIF(previous_year, 0) * 100,
        2
    ) AS percent_diff
FROM notyet
ORDER BY year;
union all
WITH gdp_cte AS (
    SELECT 
        country,
        year,
        ROUND((gdp::numeric / population::numeric), 2) AS gdp_per_capita
    FROM economies
    WHERE country IN ('Hungary', 'Slovakia')
      AND year > 2000
), lol AS (
    SELECT 
        a.year,
        a.country AS country_a,
        b.country AS country_b,
        a.gdp_per_capita AS gdp_pc_a,
        b.gdp_per_capita AS gdp_pc_b,
        ROUND((a.gdp_per_capita - b.gdp_per_capita)::numeric, 2) AS difference
    FROM gdp_cte a
    JOIN gdp_cte b 
        ON a.year = b.year 
       AND a.country <> b.country
), final AS (
    SELECT *
    FROM lol
    WHERE country_a = 'Slovakia'
), notyet AS (
    SELECT *,
           LAG(difference) OVER (ORDER BY year) AS previous_year
    FROM final
)
SELECT 
    year, 
    country_a, 
    country_b, 
    gdp_pc_a, 
    gdp_pc_b,
    difference,
    previous_year,
    round((difference-previous_year)::numeric,0) as clean_diff,
    ROUND(
        (difference - previous_year) 
        / NULLIF(previous_year, 0) * 100,
        2
    ) AS percent_diff
FROM notyet
ORDER BY year;

/*Dotaz nefunguje, pretože:

UNION ALL + nový WITH = syntaktická chyba v PostgreSQL

Riešenie:

Použiť jeden univerzálny WITH blok, ktorý spracuje všetky dvojice naraz.*/

-- AI improvement:

WITH base AS (
    SELECT 
        country,
        year,
        ROUND((gdp::numeric / population::numeric), 2) AS gdp_pc
    FROM economies
    WHERE country IN ('Poland', 'Czech Republic', 'Slovakia', 'Hungary')
      AND year > 2000
),
pairs AS (
    SELECT 
        a.year,
        a.country AS country_a,
        b.country AS country_b,
        a.gdp_pc AS gdp_pc_a,
        b.gdp_pc AS gdp_pc_b,
        ROUND((a.gdp_pc - b.gdp_pc)::numeric, 2) AS difference
    FROM base a
    JOIN base b 
        ON a.year = b.year
       AND a.country <> b.country
),
filtered AS (
    SELECT *
    FROM pairs
    WHERE country_a < country_b   -- remove duplicates like (CZ,PL) + (PL,CZ)
),
lagged AS (
    SELECT
        *,
        LAG(difference) OVER (
            PARTITION BY country_a, country_b 
            ORDER BY year
        ) AS previous_year
    FROM filtered
)
SELECT
    year,
    country_a,
    country_b,
    gdp_pc_a,
    gdp_pc_b,
    difference,
    previous_year,
    ROUND((difference - previous_year)::numeric, 0) AS clean_diff,
    ROUND(
        (difference - previous_year) 
        / NULLIF(previous_year, 0) * 100,
        2
    ) AS percent_diff
FROM lagged
ORDER BY country_a, country_b, year;


