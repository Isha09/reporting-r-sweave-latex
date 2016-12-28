###########################################################################################################
#                                                                                                         #
# This script creates and sends monthly Walmart sales stats to Walmart manager.                           #
# The report contains monthly sales for each store located in US,                                         #
# Average Holiday/NonHoliday Sales and comparison of previous and current month sales                     #
# Author - Esha chaudhary                                                                                 #
# 12-26-2016 - created first version                                                                      #
# 12-27-2016 - created config file to be used in script                                                   #
###########################################################################################################

#!/bin/bash
#enter month and year for which report needs to be generated
source /home/cloudera/Desktop/walmartConfig

echo "Preparing Walmart report for "$monthname"-"$year

#calls R script that extracts the data from MySQL db and plots graph for the report
Rscript $path/$rScript".r" $month $year $user $pwd $dbname

#create report in pdf from tex file generated after running R script
pdflatex $path/$texScript".tex"

#Rename report name
mv $path/$texScript".pdf" $path/"walmartReport_"$month"_"$year".pdf"

#Sending report to manager
echo "Hi, PFA monthly sales report"|mail -s "Walmart Sales stats"  -a $path/"walmartReport_"$month"_"$year".pdf"  $mgrEmail

echo "Report sent"
