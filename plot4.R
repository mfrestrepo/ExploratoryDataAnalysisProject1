#Download data
if(!file.exists('data.zip')){
  url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  
  download.file(url,destfile = "data.zip")
}

#Unzip data
unzip("data.zip") 

#Read data
data<-read.table("household_power_consumption.txt",header = TRUE, sep= ";")

#Organize data
names(data)

lapply(data, class)

data$DateTime<-paste(data$Date, data$Time)

#Change time format
data$DateTime<-strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

#Choose data
start<-which(data$DateTime==strptime("2007-02-01", "%Y-%m-%d"))

end<-which(data$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))

data2<-data[start:end,]

#Plot4
par(mfcol=c(2,2))

plot(data2$DateTime, as.numeric(as.character(data2$Global_active_power)),type='l',ylab="Global Active Power", xlab="")

plot(data2$DateTime, as.numeric(as.character(data2$Sub_metering_1)),type='l', xlab="",ylab ="Energy sub metering")
lines(data2$DateTime, as.numeric(as.character(data2$Sub_metering_2)),type='l', col='red')
lines(data2$DateTime, data2$Sub_metering_3,type='l', col="blue")
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),col=c("black","red","blue"))

plot(data2$DateTime, as.numeric(as.character(data2$Voltage)),type='l', 
     ylab="Voltage",xlab="datetime" )

plot(data2$DateTime, as.numeric(as.character(data2$Global_reactive_power)),type='l', 
     ylab="Global_reactive_power",xlab="datetime" )
