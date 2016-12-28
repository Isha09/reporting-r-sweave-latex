###########################################################################################################
#                                                                                                         #
# This script creates and emails monthly Walmart sales stats report.                                      #
# The report contains monthly sales for each walmart store      ,                                         #
# Average Holiday/NonHoliday Sales and comparison of previous and current month sales                     #
# Author - Esha chaudhary                                                                                 #
#                                                                                                         #
#                                                                                                         #
###########################################################################################################

#!/bin/bash
#take params from config file
source <path to config file>/walmartConfig

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
