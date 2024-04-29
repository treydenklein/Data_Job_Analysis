-- Upload data from csv files into database tables

COPY job_postings
FROM 'C:\Users\treyd\Projects\Data_Analytics\Data_Analysis_Portfolio_Projects\Job_Market_Analysis\csv_files\job_postings.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY companies_dim
FROM 'C:\Users\treyd\Projects\Data_Analytics\Data_Analysis_Portfolio_Projects\Job_Market_Analysis\csv_files\companies_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY skills_dim
FROM 'C:\Users\treyd\Projects\Data_Analytics\Data_Analysis_Portfolio_Projects\Job_Market_Analysis\csv_files\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY job_skills_dim
FROM 'C:\Users\treyd\Projects\Data_Analytics\Data_Analysis_Portfolio_Projects\Job_Market_Analysis\csv_files\job_skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


/*
Database Load Issues (follow if receiving permission denied when running SQL code above)

NOTE: If you are having issues with permissions. And you get error: 

'could not open file "[your file path]\job_postings.csv" for reading: Permission denied.'

1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `data_job_analysis` database
3. Right-click `data_job_analysis` and select `PSQL Tool`
    - This opens a terminal window to write the following code
4. Get the absolute file path of your csv file
    1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
5. Paste the following into `PSQL Tool`, (with the CORRECT file path)

\copy job_postings FROM '[your file path]\job_postings.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy companies_dim FROM '[your file path]\companies_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM '[your file path]\skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy job_skills_dim FROM '[your file path]\job_skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

*/