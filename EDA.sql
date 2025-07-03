-- ------------------------------------------------------------------
  -- EXPLORATORY DATA ANALYSIS (EDA) ON layoffs_staging2
-- -------------------------------------------------------------------


-- Quick look at the entire cleaned dataset
SELECT * 
FROM layoffs_staging2;


-- Identify the highest single‑round layoff counts and
--      the largest layoff percentages (max = 1 → 100 %)
SELECT
    MAX(total_laid_off)       AS max_total_laid_off,
    MAX(percentage_laid_off)  AS max_pct_laid_off
FROM layoffs_staging2;


--  Companies that laid off 100 % of their workforce,
--      sorted by the most capital raised
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1          -- 100 % layoffs
ORDER BY funds_raised_millions DESC;


--  Total layoffs by company (largest first)
SELECT
    company,
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY company
ORDER BY total_laid_off DESC;


--  Earliest and latest layoff dates in the dataset
SELECT
    MIN(`date`) AS first_layoff_date,
    MAX(`date`) AS last_layoff_date
FROM layoffs_staging2;


--  Layoffs aggregated by industry
SELECT
    industry,
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY industry
ORDER BY total_laid_off DESC;


--  Layoffs aggregated by country
SELECT
    country,
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY country
ORDER BY total_laid_off DESC;


--   Layoffs by individual layoff date
SELECT
    `date`,
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY `date`
ORDER BY total_laid_off DESC;


--  Layoffs by funding/operational stage (e.g., Seed, Series A, IPO)
SELECT
    stage,
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
GROUP BY stage
ORDER BY stage;


--  Monthly layoff trend (YYYY‑MM) *
--     *Using SUBSTRING assumes `date` is stored as DATE; adjust as needed.
SELECT
    SUBSTRING(`date`, 1, 7) AS month,   -- e.g., 2023-04
    SUM(total_laid_off)     AS total_laid_off
FROM layoffs_staging2
WHERE `date` IS NOT NULL                -- exclude null dates
GROUP BY month
ORDER BY month;
