-- Standardize the Data:


-- fixing issue with white spaces
SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT  *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';


-- fixing issue with duplicate names by writed in different way
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';


-- removing a dot from the end of a string
SELECT  *
FROM layoffs_staging2
WHERE industry LIKE 'United States%';

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';


-- method that removes characters specified from the end of a string
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country) 
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


-- change date from 'text' to 'date' format
SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')  
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');  

SELECT `date`
FROM layoffs_staging2;

-- change columns format to (from 'text' to 'date')
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


