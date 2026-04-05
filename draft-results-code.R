#NOAA water temperature data from 2020-2024 Hurricane Sally prevented any data from 2021
library(dplyr)
library(tidyr)
library(stringr)

wtemp<- rbind(
  read.csv("CSV/Temp/Temp2002.csv"), 
  read.csv("CSV/Temp/Temp2003.csv"),
  read.csv("CSV/Temp/Temp2004.csv"), 
  read.csv("CSV/Temp/Temp2005.csv"),
  read.csv("CSV/Temp/Temp2006.csv"), 
  read.csv("CSV/Temp/Temp2007.csv"),
  read.csv("CSV/Temp/Temp2008.csv"), 
  read.csv("CSV/Temp/Temp2009.csv"),
  read.csv("CSV/Temp/Temp2010.csv"), 
  read.csv("CSV/Temp/Temp2011.csv"),
  read.csv("CSV/Temp/Temp2012.csv"), 
  read.csv("CSV/Temp/Temp2013.csv"),
  read.csv("CSV/Temp/Temp2014.csv"), 
  read.csv("CSV/Temp/Temp2015.csv"),
  read.csv("CSV/Temp/Temp2016.csv"), 
  read.csv("CSV/Temp/Temp2017.csv"),
  read.csv("CSV/Temp/Temp2018.csv"), 
  read.csv("CSV/Temp/Temp2019.csv"),
  read.csv("CSV/Temp/Temp2020.csv"), 
  read.csv("CSV/Temp/Temp2022.csv"),
  read.csv("CSV/Temp/Temp2023.csv"), 
  read.csv("CSV/Temp/Temp2024.csv"), 
  read.csv("CSV/Temp/Temp2025.csv")
)

#EIA consumption and sales data from 2020-2024
econsumpold<- rbind(
  read.csv("CSV/Consump/Consump2002.csv", header=TRUE),
  read.csv("CSV/Consump/Consump2003.csv", header=TRUE),
  read.csv("CSV/Consump/Consump2004.csv", header=TRUE),
  read.csv("CSV/Consump/Consump2005.csv", header=TRUE)
)

econsumpold2<- bind_rows(
  read.csv("CSV/Consump/Consump2011.csv", header=TRUE),
  read.csv("CSV/Consump/Consump2012.csv", header=TRUE)
) 

econsumpold3<- bind_rows(
  read.csv("CSV/Consump/Consump2008.csv", header=TRUE),
  read.csv("CSV/Consump/Consump2009.csv", header=TRUE))

econsumpold4<- bind_rows(
  read.csv("CSV/Consump/Consump2006.csv", header=TRUE)
)

econsumpold5<- read.csv("CSV/Consump/Consump2007.csv", header=TRUE)
econsumpold5$YEAR<- 2007 

econsumpold6<- rbind(
  read.csv("CSV/Consump/Consump2013.csv", header=TRUE, skip = 2)
)

econsumpold7<- read.csv("CSV/Consump/Consump2010.csv", header=TRUE)

econsumpnew<- rbind(
  read.csv("CSV/Consump/Consump2014.csv", header=TRUE, skip = 2),
  read.csv("CSV/Consump/Consump2015.csv", header=TRUE, skip = 2),
  read.csv("CSV/Consump/Consump2016.csv", header=TRUE, skip = 2),
  read.csv("CSV/Consump/Consump2017.csv", header=TRUE, skip = 2),
  read.csv("CSV/Consump/Consump2018.csv", header=TRUE, skip = 2),
  read.csv("CSV/Consump/Consump2019.csv", header=TRUE, skip = 2),
  read.csv("CSV/Consump/Consump2020.csv", header=TRUE, skip = 2),
  read.csv("CSV/Consump/Consump2021.csv", header=TRUE, skip = 2),
  read.csv("CSV/Consump/Consump2022.csv", header=TRUE, skip = 2),
  read.csv("CSV/Consump/Consump2023.csv", header=TRUE, skip = 2),
  read.csv("CSV/Consump/Consump2024.csv", header=TRUE, skip = 2),
  read.csv("CSV/Consump/Consump2025.csv", header=TRUE, skip = 2)
)

#EIA generation data from Barry
egen<- read.csv("CSV/Barry_net_generation (1).csv", skip=4)

#Cleaning

econsumpnew<- setNames(econsumpnew, c("Year", "Month", "Num", "Name", "State", "Ownership", "Data_Status", "RR", "RS", "RC", "CR", "CS", "CC", "IR", "IS", "IC","TR", "TS", "TC", "TotalR", "TotalS", "TotalC"))
econsumpold<- setNames(econsumpold, c("Num", "Name", "State", "Year", "Month", "Ownership", "Data_Status", "RC", "CR", "CS", "CC", "IR", "IS", "IC","TR", "TS", "TC","TotalR", "TotalS", "TotalC"))
econsumpold2<- setNames(econsumpold2, c("Num", "Name", "State", "Year", "Month", "Ownership", "Data_Status", "RC", "CR", "CS", "CC", "IR", "IS", "IC","TR", "TS", "TC","TotalR", "TotalS", "TotalC"))
econsumpold3<- setNames(econsumpold3, c("Num", "Name", "State", "Year", "Month", "Ownership", "Data_Status", "RC", "CR", "CS", "CC", "IR", "IS", "IC","TR", "TS", "TC","TotalR", "TotalS", "TotalC"))
econsumpold4<- setNames(econsumpold4, c("Num", "Name", "State", "Year", "Month", "Ownership", "Data_Status", "RC", "CR", "CS", "CC", "IR", "IS", "IC","TR", "TS", "TC","TotalR", "TotalS", "TotalC"))
econsumpold5<- setNames(econsumpold5, c("Num", "Name", "State", "Year", "Month", "Ownership", "Data_Status", "RC", "CR", "CS", "CC", "IR", "IS", "IC","TR", "TS", "TC","TotalR", "TotalS", "TotalC"))
econsumpold6<- setNames(econsumpold6, c("Year", "Month", "Num", "Name", "State", "Ownership", "Data_Status", "RC", "CR", "CS", "CC", "IR", "IS", "IC","TR", "TS","blank",  "TC","TotalR", "TotalS", "TotalC"))
econsumpold7<- setNames(econsumpold7, c("Num", "Name", "State", "Year", "Month", "Ownership", "Data_Status", "RC", "CR", "CS", "CC", "IR", "IS", "IC","TR", "TS", "TC","TotalR", "TotalS", "TotalC"))

econsump<- rbind(
  econsumpold[, c(1:5, 19)],
  econsumpold2[, c(1:5, 19)],
  econsumpold3[, c(1:5, 19)],
  econsumpold4[, c(1:5, 19)],
  econsumpold5[, c(1:5, 19)],
  econsumpold6[, c(1:5, 20)],
  econsumpold7[, c(1:5, 19)],
  econsumpnew[,c(1:5, 21)])

Alco<- econsump |> filter(Name == "Alabama Power Co")

Alco$Month<- month.abb[Alco$Month]

Alco$TotalS<- as.numeric(gsub(",", "", Alco$TotalS))

names(egen)<- c('Month', 'Normal Capacity')
egen<- egen[, c(1:2)]
egen<- separate(egen, Month, into = c("Month", "Year"), sep=" ")
egen<- egen |> filter(Year >= 2002 & Year <= 2025)

wtemp<- separate(wtemp, Date, into = c("Year", "Month", "Day"), sep="\\/")

#Gen and Consumption
MWcap_py<- 14519034/1000*(365*24)

barcont<- egen|> group_by(Year) |> summarise(cont = sum(`Normal Capacity`, na.rm = TRUE)/MWcap_py)

barcont<- mean(barcont$cont)

consume_py<- Alco |> group_by(Year) |> summarise(Consumed_Per_Year = sum(as.numeric(gsub(",", "", TotalS)), na.rm = TRUE))

consume_py$Consumed_Per_Year<- consume_py$Consumed_Per_Year/MWcap_py

contbybar<- consume_py
contbybar$Consumed_Per_Year<- consume_py$Consumed_Per_Year * barcont
mean(contbybar$Consumed_Per_Year)

#Predicted wtemp

egen$consump<- Alco$TotalS* contbybar$Consumed_Per_Year

egen$Year<- as.numeric(egen$Year)
egen$Month<- factor(egen$Month)

cmodel<- lm(consump ~ Year * Month, data=egen)

fegen<- expand.grid(
  Year = seq(max(egen$Year) + 1, max(egen$Year) + 5),
  Month = levels(egen$Month))

fegen$consump<- predict(cmodel, newdata = fegen)

gmodel<- lm(`Normal Capacity` ~ Year * Month, data=egen)

fegen$`Normal Capacity`<- predict(gmodel, newdata = fegen)

egen<- rbind(egen, fegen)

#reduce cap
egen$`10% Reduced Capacity`<- egen$`Normal Capacity`*.9
egen$`20% Reduced Capacity`<- egen$`Normal Capacity`*.8
egen$`30% Reduced Capacity`<- egen$`Normal Capacity`*.7

egen<- egen |> pivot_longer(cols = c(3, 5:7), names_to = "Capacity", values_to = "net_gen")

ngen<- egen
ngen$pu<- ngen$consump/ngen$net_gen


#Past Threshold
wtemp$Water.Temp...F.<- as.numeric(wtemp$Water.Temp...F.) 

mtempm<- wtemp
mtempm<- mtempm |> filter(!is.na(mtempm$Water.Temp...F.) == TRUE)
mtempm<- mtempm |> group_by(Year, Month)
mtempm<- mtempm |> summarise(Mean_Temp = mean(Water.Temp...F., na.rm = TRUE))

ptemp<- wtemp
ptemp<- ptemp |> filter(!is.na(ptemp$Water.Temp...F.) == TRUE) 
ptemp<- ptemp |> group_by(Year, Month)
ptemp<- ptemp |> summarise(Prop_Temp = mean(Water.Temp...F. > 85, na.rm = TRUE))

optemp<- ptemp |> group_by(Month)
optemp<- optemp |> summarise(Prop_Temp = mean(Prop_Temp, na.rm = TRUE))

omtemp<- mtempm |> group_by(Month)
omtemp<- omtemp |> summarise(Mean_Temp = mean(Mean_Temp, na.rm = TRUE))

std_err <- wtemp
std_err <- std_err |> filter(!is.na(std_err$Water.Temp...F.) == TRUE)
std_err <- std_err |> group_by(Month) |> summarise(StdErr = sd(Water.Temp...F.) / sqrt(length(Water.Temp...F.)))

cinfw<- wtemp
cinfw<- cinfw |> filter(!is.na(cinfw$Water.Temp...F.) == TRUE)
cinfw<- cinfw |> group_by(Month)
cinfw<- cinfw |> summarise(
  ConfInt_Low = mean(Water.Temp...F.) - 1.96 * (sd(Water.Temp...F.)/sqrt(length(Water.Temp...F.))),
  Mean = mean(Water.Temp...F.),
  ConfInt_High = mean(Water.Temp...F.) + 1.96 * (sd(Water.Temp...F.)/sqrt(length(Water.Temp...F.)))
)

#Past Threshold Seperated by time of day
wtemp$Water.Temp...F.<- as.numeric(wtemp$Water.Temp...F.) 

mtempm<- wtemp
mtempm<- mtempm |> filter(!is.na(mtempm$Water.Temp...F.) == TRUE)
mtempm<- mtempm |> group_by(Year, Month)
mtempm<- mtempm |> summarise(Mean_Temp = mean(Water.Temp...F., na.rm = TRUE))

ptemp<- wtemp
ptemp<- ptemp |> filter(!is.na(ptemp$Water.Temp...F.) == TRUE) 
ptemp<- ptemp |> group_by(Year, Month)
ptemp<- ptemp |> summarise(Prop_Temp = mean(Water.Temp...F. > 85, na.rm = TRUE))

optemp<- ptemp |> group_by(Month)
optemp<- optemp |> summarise(Prop_Temp = mean(Prop_Temp, na.rm = TRUE))

omtemp<- mtempm |> group_by(Month)
omtemp<- omtemp |> summarise(Mean_Temp = mean(Mean_Temp, na.rm = TRUE))

std_err <- wtemp
std_err <- std_err |> filter(!is.na(std_err$Water.Temp...F.) == TRUE)
std_err <- std_err |> group_by(Month) |> summarise(StdErr = sd(Water.Temp...F.) / sqrt(length(Water.Temp...F.)))

cinfw<- wtemp
cinfw<- cinfw |> filter(!is.na(cinfw$Water.Temp...F.) == TRUE)
cinfw<- cinfw |> group_by(Month)
cinfw<- cinfw |> summarise(
  ConfInt_Low = mean(Water.Temp...F.) - 1.96 * (sd(Water.Temp...F.)/sqrt(length(Water.Temp...F.))),
  Mean = mean(Water.Temp...F.),
  ConfInt_High = mean(Water.Temp...F.) + 1.96 * (sd(Water.Temp...F.)/sqrt(length(Water.Temp...F.)))
)

#Predicted wtemp

mtempm$Year<- as.numeric(mtempm$Year)
mtempm$Month<- factor(month.name[as.numeric(mtempm$Month)],
                      levels = month.name)

tmodel<- lm(Mean_Temp ~ Year * Month, data=mtempm)

fwtemp<- expand.grid(
  Year = seq(max(mtempm$Year) + 1, max(mtempm$Year) + 5),
  Month = levels(mtempm$Month))

fwtemp$Mean_Temp<- predict(tmodel, newdata = fwtemp)

mtempm<- rbind(mtempm, fwtemp)

