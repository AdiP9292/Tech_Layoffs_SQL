-- ---------------------------------------------------------------
-- STEP 2: STANDARDIZE THE DATA
-- ---------------------------------------------------------------



-- COMPANY: Remove leading/trailing spaces from company names
SELECT company, TRIM(company)
FROM layoffs_staging2;


-- Update company names to remove any extra whitespace
UPDATE layoffs_staging2
SET company = TRIM(company);


-- INDUSTRY: Review distinct industry values to identify inconsistencies
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

-- View all rows where industry starts with 'Crypto' (e.g., 'Crypto', 'Crypto/Web3', etc.)
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

-- Standardize all such variations to a single value: 'Crypto'
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- END INDUSTRY STANDARDIZATION


-- LOCATION: Review unique location entries for potential normalization
SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

--  END LOCATION REVIEW


-- COUNTRY: Standardize inconsistent naming for 'United States'
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;


-- Find rows where 'country' starts with 'United States' (e.g., has trailing commas, whitespace)
SELECT *
FROM layoffs_staging2
WHERE country LIKE 'United States%';


-- Normalize all such rows to 'United States'
UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';


-- Remove any trailing commas from the 'country' field
UPDATE layoffs_staging2
SET country = TRIM(TRAILING ',' FROM country)
WHERE country LIKE 'United States%';


-- Re-check distinct country values to confirm changes
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

-- END COUNTRY STANDARDIZATION

-- DATE: Convert 'date' from string format to proper DATE format


-- Preview how current 'date' strings will look when converted using STR_TO_DATE
SELECT `date`,
       STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;


-- Update the 'date' column with converted date values
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');


-- Change the data type of 'date' column from TEXT to DATE
-- (Must be done after format conversion to avoid error)
ALTER TABLE layoffs_staging2 
MODIFY COLUMN `date` DATE;

-- END DATE STANDARDIZATION
