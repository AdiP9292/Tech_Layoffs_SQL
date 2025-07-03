-- -------------------------------------------------------------------
-- STEP 3: HANDLE NULL VALUES OR BLANK FIELDS IN THE DATASET
-- -------------------------------------------------------------------


-- Identify records where both total_laid_off and percentage_laid_off are the string 'NULL'
-- ️ Note: If these fields are of type TEXT, 'NULL' is a string, not an actual SQL NULL.
SELECT * 
FROM layoffs_staging2
WHERE total_laid_off = 'NULL'
  AND percentage_laid_off = 'NULL';


-- Check for missing (blank or 'NULL') values in the industry column
SELECT *
FROM layoffs_staging2
WHERE industry = 'NULL' OR industry = '';


-- Replace empty strings ('') in the industry column with a consistent placeholder 'NULL'
-- This simplifies filtering and standardizes the missing values
UPDATE layoffs_staging2 
SET industry = 'NULL'
WHERE industry = '';


--  Inspect records related to a known company (e.g., Airbnb)
-- Used to verify if there are duplicate entries or inconsistent values
SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';


-- Cross-reference companies with NULL industry values
-- Join the table to itself to fill in missing industry values using a matching company and location
SELECT t1.industry AS null_industry, t2.industry AS valid_industry
FROM layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
  ON t1.company = t2.company 
  AND t1.location = t2.location
WHERE (t1.industry = 'NULL' OR t1.industry = '')
  AND t2.industry != 'NULL';


-- Update NULL/blank industry fields using values from matching records
-- Fills missing industry values based on other entries with the same company
UPDATE layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
  ON t1.company = t2.company 
SET t1.industry = t2.industry
WHERE (t1.industry = 'NULL' OR t1.industry = '')
  AND t2.industry != 'NULL';


-- Search for entries related to a specific company (e.g., Bally) for manual review
-- Helps catch data quality issues or spelling inconsistencies
SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';


-- Final review of the entire cleaned dataset
-- Ensures all changes are reflected and data is ready for the next step
SELECT *
FROM layoffs_staging2;
