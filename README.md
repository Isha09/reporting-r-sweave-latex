# reporting-r-sweave-latex
Simple reporting automation tool created using R,Sweave,Latex

**Description:**
This is a simple end to end reporting tool created using R,Sweave and Latex that runs on *nix platform.
This has been developed using sample walmart store sales data.
The data has been loaded first into MySQL database.

_walmartMonthlyReport.sh_- the shell scripts picks up the month, year, email and other params from a config file named walmartConfig. It then calls the R script and runs the tex document generated to create the final pdf report. Report is then mailed to emailid provided in config file.

_walmartSales.r_ - This R scripts extracts data for the stats to be represented in the report from MySQL db for the month and year passed as an argument to the script. It then calls the sweave script for the plotting of graphs.

_walmartMonthlyReport.rnw_ - The sweave scripts contains R code that draws the graphs and finally creates the tex file to be used to create the final report.

**Report shows the following stats:**
1. In a given month,list stores doing good to bad.(Represented using bar plot)
2. In a given month compare average holiday/NonHoliday Sales.(Represented using bar plot)
3. In a given month compare the sales with all previous months. (Represented using pie chart)

**Data Explanation:**

_stores.csv_
This file contains anonymized information about the 45 stores, indicating the type and size of store.

_training.csv_
This is the historical training data and contains the following fields:
Store - the store number
Dept - the department number
Date - the week
Weekly_Sales -  sales for the given department in the given store
IsHoliday - whether the week is a special holiday week

