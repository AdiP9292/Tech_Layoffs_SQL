-- View the raw data from the original table
SELECT * 
FROM layoffs; 

-- ---------------------------------------------------------------
-- STEP 1: REMOVE DUPLICATES
-- ---------------------------------------------------------------


-- Create a copy of the original 'layoffs' table into a staging table
CREATE TABLE layoffs_staging
LIKE layoffs;


-- Verify the structure of the new staging table
SELECT * 
FROM layoffs_staging;


-- Insert all records from the original table into the staging table
INSERT INTO layoffs_staging
SELECT * 
FROM layoffs;



-- Attempt 1: Try to remove duplicates using a CTE and ROW_NUMBER()
-- This approach identifies duplicates by assigning row numbers
-- over the columns that define a "duplicate" row
WITH duplicate_cte AS (
  SELECT *, 
    ROW_NUMBER() OVER (
      PARTITION BY company, location, industry, total_laid_off, 
                   percentage_laid_off, `date`, stage, country, 
                   funds_raised_millions
      ) AS row_num
  FROM layoffs_staging
)


-- Note: DELETE directly from CTE won't work in MySQL
-- Keeping it here for explanation purposes only
DELETE 
FROM duplicate_cte
WHERE row_num > 1;


-- ---------------------------------------------------------------
-- STEP 2: Create a new table with ROW_NUMBER column to aid deletion
-- ---------------------------------------------------------------

-- Create a second staging table with an additional 'row_num' column
CREATE TABLE layoffs_staging2 (
  `company` TEXT,
  `location` TEXT,
  `industry` TEXT,
  `total_laid_off` TEXT,
  `percentage_laid_off` TEXT,
  `date` TEXT,
  `stage` TEXT,
  `country` TEXT,
  `funds_raised_millions` TEXT DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- Confirm the structure of the new table
SELECT * 
FROM layoffs_staging2;



-- Insert data into the new table and assign ROW_NUMBER() to identify duplicates
INSERT INTO layoffs_staging2
SELECT *, 
  ROW_NUMBER() OVER (
    PARTITION BY company, location, industry, total_laid_off, 
                 percentage_laid_off, `date`, stage, country, 
                 funds_raised_millions
  ) AS row_num
FROM layoffs_staging;



-- Delete duplicate rows based on row_num > 1
-- Only the first occurrence (row_num = 1) is kept
DELETE 
FROM layoffs_staging2
WHERE row_num > 1;


-- At this point, layoffs_staging2 contains only unique rows
