#First comments are codes for downloading data,unzip and set working directory

#url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#download.file(url,"project_4_1.zip",method = "curl")
#unzip("./project_4_1.zip",exdir = "./project")
#setwd("./project")

#loading data

#read desired dates only
df<- read.table("./household_power_consumption.txt",nrows = 70000,  header = T, sep = ";",stringsAsFactors = F, na.strings = "?")
df<- subset(df,Date=="1/2/2007"|df$Date=="2/2/2007")
library(plyr)

#parse date and time
df<- mutate(df,datetimepaste=paste(Date,Time),datetime=strptime(datetimepaste,"%d/%m/%Y %H:%M:%S"))
df<-subset(df,select = -datetimepaste)

#ploting at png grafic device

png("plot4.png",width=480,height=480,units="px")
par(mfrow=c(2,2))

#plot1
with(df,plot(datetime,Global_active_power,type = "l",ylab = "Global active power",xlab = ""))

#plot2
with(df,plot(datetime,Voltage,type="l"))

#plot3
with(df,plot(datetime,Sub_metering_1,type="n",xlab = "", ylab="Energy Sub Metering"))
with(df,lines(datetime,Sub_metering_1))
with(df,lines(datetime,Sub_metering_2,col="red"))
with(df,lines(datetime,Sub_metering_3,col="blue"))
with(df,legend("topright",bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1))

#plot4
with(df,plot(datetime,Global_reactive_power,type="l"))


dev.off()
