select * 
from layoffs;
create table layoff_staging 
like layoffs; 
select * 
from layoff_staging; 
insert layoff_staging 
select * 
from layoffs; 
select * 
from layoff_staging; 
-- Removing the duplicates 
select * 
from layoff_staging; 
select * ,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num 
from layoff_staging; 
with duplicate_cte as 
(
select * ,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num 
from layoff_staging) 
select * 
from duplicate_cte
where row_num>1; 
CREATE TABLE `layoff_staging3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
select * 
from layoff_staging3; 
insert into layoff_staging3
select * ,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num 
from layoff_staging; 
select * 
from layoff_staging3 
where row_num >1; 
delete 
from layoff_staging3 
where row_num>1; 
select * 
from layoff_staging3; 
-- Standardising the data 
select trim(company) 
from layoff_staging3; 
update layoff_staging3 
set company = trim(company); 
select distinct industry 
from layoff_staging3 
order by 1;
select * 
from layoff_staging3 
where industry like 'crypto'; 
update layoff_staging3 
set industry = 'crypto' 
where industry like 'crypto%'; 
select distinct industry 
from layoff_staging3; 
select distinct country 
from layoff_staging3 ;
 
select distinct country , trim(trailing '.' from country) as me
from layoff_staging3 
order by 1;
update layoff_staging3 
set country = trim(trailing '.' from country) 
where country like 'united states%' ; 

select * 
from layoffs 
join 



