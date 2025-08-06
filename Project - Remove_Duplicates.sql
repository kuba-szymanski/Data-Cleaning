-- Data Cleaning - Project

-- Things to do:
-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null values or blank values
-- 4. Remove any columns

-- Remove Duplicates:

-- Create 'backup' table for manipulate data
CREATE TABLE layoffs_staging   
LIKE layoffs;

-- Insert table values from layoffs to layoffs_staging
SELECT *
FROM layoffs_staging;

INSERT layoffs_staging		
SELECT *
FROM layoffs;


-- allocation row_num for each rows
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;


-- Finds duplicates
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location,
 industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Find an exact duplicate
SELECT *
FROM layoffs_staging
WHERE company = 'Cazoo';


-- create another table for delete duplicates
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

-- Insert table values from layoffs_staging to layoffs_staging2
INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location,
 industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;


-- delete duplicates
DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- checking that duplicates are exist
SELECT * 
FROM layoffs_staging2
WHERE row_num > 1;










