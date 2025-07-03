# Tech Layoffs Data Analysis with SQL 

## Clean, Transform, and Explore Layoffs Data from Kaggle

This project showcases the end-to-end process of data cleaning and exploratory analysis using MySQL on a layoffs dataset sourced from Kaggle. It provides valuable insights into tech layoffs, including trends by company, industry, country, and time.

## Dataset Overview

File: layoffs.csv

### Description:
The dataset contains public information on global tech layoffs, including details like:

- `company`: Name of the company laying off employees

- `location`, country: Geographical details

- `industry`: Type of business

- `total_laid_off`: Number of employees laid off

- `percentage_laid_off`: Share of the company’s workforce affected

- `funds_raised_millions`: Total funding raised before layoffs

- `stage`: Startup stage (e.g., Series A, Series B, IPO)

- `date`: Date of the layoff event


## SQL-Based Data Cleaning Steps
### Actions:
- Created a staging table from the raw dataset
- Used ROW_NUMBER() to identify and remove duplicate records
- Ensured integrity by inserting only the first occurrence of each record

### Standardized:
- Company names (trimmed whitespaces)
- Industry labels (e.g., all "Crypto/Web3", "Crypto Exchange" → "Crypto")
- Country names (standardized "United States," etc.)
- Date column converted from string to proper DATE format

### Null Handling:
- Standardized 'NULL' strings and empty values
- Used self-joins to intelligently fill missing industry values based on company and location
- Cleaned ambiguous entries

### Final Cleanup:
- Removed rows where both total_laid_off and percentage_laid_off were 'NULL'
- Dropped helper columns like row_num after de-duplication

## Exploratory Data Analysis (EDA)
### Key Insights Extracted:

- Top companies by total layoffs

- Industries and countries most affected

- Dates and months with peak layoffs

- Startups at the highest layoff numbers

- Identified companies with 100% layoffs

- Temporal trend analysis (`month`, `total_laid_off`)
