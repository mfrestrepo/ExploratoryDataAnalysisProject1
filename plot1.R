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

#Plot1
hist(as.numeric(as.character(data2$Global_active_power)), # note we used as.character and as numeric since
     # the variable is factor variable.
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red")

