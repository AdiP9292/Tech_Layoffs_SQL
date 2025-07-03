-- --------------------------------------------------------------------
-- STEP 4: REMOVE UNNECESSARY ROWS AND COLUMNS
-- --------------------------------------------------------------------


-- Identify rows where both total_laid_off and percentage_laid_off are 'NULL'
-- These rows likely contain no useful data and can be removed
SELECT * 
FROM layoffs_staging2
WHERE total_laid_off = 'NULL'
  AND percentage_laid_off = 'NULL';


-- Delete those rows from the dataset
-- This cleans up completely blank or uninformative entries
DELETE 
FROM layoffs_staging2
WHERE total_laid_off = 'NULL'
  AND percentage_laid_off = 'NULL';


-- Re-run the SELECT to confirm deletion
-- Ensures no such rows remain in the dataset
SELECT * 
FROM layoffs_staging2
WHERE total_laid_off = 'NULL'
  AND percentage_laid_off = 'NULL';


-- View the entire table to confirm current dataset state
-- Final visual check before dropping unnecessary columns
SELECT * 
FROM layoffs_staging2;


-- Drop the 'row_num' column
-- This was used only temporarily for deduplication and is no longer needed
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;
