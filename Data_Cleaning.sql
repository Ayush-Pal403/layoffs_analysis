-- DATA CLEANING--

SELECT * FROM
layoffs;

CREATE TABLE layoffs_staging 
LIKE layoffs;

SELECT * FROM
layoffs_staging;

INSERT INTO layoffs_staging
SELECT * FROM layoffs;

SELECT *, row_number() OVER(PARTITION BY company, location, industry,
 total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
 FROM layoffs_staging;
 
 WITH ct1 AS
 (SELECT *, row_number() OVER(PARTITION BY company, location, industry,
 total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
 FROM layoffs_staging)
 SELECT * FROM ct1
 WHERE row_num >1;
 
 SELECT * FROM layoffs_staging
 WHERE company = 'casper';
 
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

SELECT * FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *, row_number() OVER(PARTITION BY company, location, industry,
 total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
 FROM layoffs_staging;
 
SELECT * FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
WHERE t1.industry is null or t1.industry = ''
AND t2.industry IS NOT NULL;
 ;
 
 SELECT * FROM layoffs_staging2 WHERE industry LIKE '%Crypto%';
 
 UPDATE layoffs_staging2
 SET company = trim(company);
 
UPDATE layoffs_staging2
SET `date` = str_to_date(`date`, '%m/%d/%Y') ;

SELECT distinct(country) FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT* FROM layoffs_staging2 
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;
SELECT * FROM
layoffs_staging2;