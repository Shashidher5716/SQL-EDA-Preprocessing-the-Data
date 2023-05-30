SELECT * FROM finalplt.livert_dataset;

 # Checking the count of rows
select count(*) from finalplt.livert_dataset;

# Checking the column values
SELECT count(*)
FROM information_schema.columns
WHERE table_name = "livert_dataset"

# Checking the duplicates
# R Rejection Episodes Column
SELECT
  'R Rejection Episodes',
  COUNT('R Rejection Episodes')
FROM 
 finalplt.livert_dataset
GROUP BY 'R Rejection Episodes'
HAVING COUNT('R Rejection Episodes') > 1; # no duplicates

# Checking the Z-Score to find the Outliers
SELECT
'R Rejection Episodes',
('R Rejection Episodes'-AVG('R Rejection Episodes') Over())/STDDEV('R Rejection Episodes') Over() as Zscore
from finalplt.livert_dataset;    # No Ouliers because it is showing NULL

# Variance
SELECT  VARIANCE('R Rejection Episodes')              
FROM finalplt.livert_dataset

# Checking Missing Values for reLTx_date
SELECT
  COUNT('R Rejection Episodes')
FROM
  finalplt.livert_dataset
WHERE
  'R Rejection Episodes' IS NULL;    # No Missing Values
  
  # EDA - Exploratory Data analysis
  # 1st Business Moment: Measures of Central Tendency
  
  # Checking the Mean
SELECT Avg('R Primary biliary')
FROM finalplt.livert_dataset;

SELECT Avg('R Alcoholic')
FROM finalplt.livert_dataset;

# Checking the Mode
SELECT 'R Alcoholic' AS Mode, COUNT(*) AS Count 
FROM finalplt.livert_dataset 
GROUP BY 'R Alcoholic' 
HAVING COUNT(*) >= ALL (SELECT COUNT(*) FROM finalplt.livert_dataset GROUP BY 'R Alcoholic');

# Checking the median
SELECT 'R Alcoholic'
FROM   (SELECT 'R Alcoholic', 
               Count(1) OVER (partition BY 'A')        AS TotalRows, 
               Row_number() OVER (ORDER BY 'R Alcoholic' ASC) AS AmountOrder 
        FROM   finalplt.livert_dataset) x 
WHERE  x.AmountOrder = Round(x.TotalRows / 2.0, 0) 

# Calculating Pearson’s median Skewness - 3 X Mean - Median / Standard Deviation
SELECT
'R WBC',
((3*AVG('R WBC')-0.3))/STDDEV('R WBC') as Skew
from finalplt.livert_dataset;

# Checking the Kurtosis
SELECT
'R Cold Ischemia Time',
(('R Cold Ischemia Time'-AVG('R Cold Ischemia Time'))/STDDEV('R Cold Ischemia Time')) as Kurt
from finalplt.livert_dataset;





  
  