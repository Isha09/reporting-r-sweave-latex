#Adding Libraries#
library(ggplot2)
library(RMySQL)

#Taking arguments from command line for month and year#
args <- commandArgs()
mnth <-args[6]
yr <- args[7]
mnthName <- month.name[as.numeric(mnth)]

#Connect to MySQL db#
myDbConn = dbConnect(MySQL(), user=args[8], password=args[9], dbname=args[10])

#Extracting monthly sales for each walmart store#
monthlySales = dbSendQuery(myDbConn,paste("select store,avg(weekly_sales) as salesPerMonth from training where month(weekdate)='",mnth,"' and year(weekdate)='",yr,"' group by store"))
monthlySalesResults = fetch(monthlySales,n=-1)

#Extracting Average Holiday/Non Holiday Sales for the month
avgSales = dbSendQuery(myDbConn,paste("select isHoliday,round(avg(weekly_sales),2) as avgSales from training where month(weekdate)='",mnth,"' and year(weekdate)='",yr,"' group by isHoliday"))
avgSalesResults = fetch(avgSales,n=-1)
avgSalesResults[1,1] <- "NonHoliday"
avgSalesResults[2,1] <- "Holiday"

#Extracting Sales for all previous months for the year
oldMonthSales=dbSendQuery(myDbConn,paste("select month(weekdate) as month ,round(avg(weekly_sales),2) as avgMonthlySales from training where year(weekdate)='",yr,"' and month(weekdate)<='",mnth,"' group by month(weekdate)"))
oldMonthSalesResults = fetch(oldMonthSales,n=-1)

#creating env var for mapping month number to month name
hashmp <- new.env()
assign("1","Jan",envir=hashmp)
assign("2","Feb",envir=hashmp)
assign("3","Mar",envir=hashmp)
assign("4","Apr",envir=hashmp)
assign("5","May",envir=hashmp)
assign("6","Jun",envir=hashmp)
assign("7","Jul",envir=hashmp)
assign("8","Aug",envir=hashmp)
assign("9","Sep",envir=hashmp)
assign("10","Oct",envir=hashmp)
assign("11","Nov",envir=hashmp)
assign("12","Dec",envir=hashmp)

  for (i in 1:length(oldMonthSalesResults$month)){
       
    oldMonthSalesResults[i,1] <- hashmp[[as.character(oldMonthSalesResults[i,1])]]
}


#Calling Sweave script to draw the graphs for monthly sales report#
Sweave("/home/cloudera/Desktop/walmartMonthlyReport.rnw")

#Closing Database connection#
dbDisconnect(myDbConn)
rm(list = ls())