#NOAA water temperature data from 2020-2024 Hurricane Sally prevented any data from 2021
wtemp<- rbind(
  read.csv("CSV/Temp/Temp2020.csv"), 
  read.csv("CSV/Temp/Temp2022.csv"),
  read.csv("CSV/Temp/Temp2023.csv"), 
  read.csv("CSV/Temp/Temp2024.csv")
)

#EIA consumption and sales data from 2020-2024
econsump<- rbind(
  read.csv("CSV/Consump/Consump2020.csv", header=TRUE, skip = 2),
  read.csv("CSV/Consump/Consump2021.csv", header=TRUE, skip = 2),
  read.csv("CSV/Consump/Consump2022.csv", header=TRUE, skip = 2),
  read.csv("CSV/Consump/Consump2023.csv", header=TRUE, skip = 2),
  read.csv("CSV/Consump/Consump2024.csv", header=TRUE, skip = 2)
)

#EIA generation data from Barry
egen<- read.csv("CSV/EnergyGeneration.csv", skip=4)

#Cleaning
library(dplyr)
library(tidyr)
library(stringr)

econsump<- setNames(econsump, c("Year", "Month", "Num", "Name", "State", "Ownership", "Data_Status", "RR", "RS", "RC", "CR", "CS", "CC", "IR", "IS", "IC","TR", "TS", "TC", "TotalR", "TotalS", "TotalC"))

Alco<- econsump |> filter(Name == "Alabama Power Co")

Alco$Month<- month.abb[Alco$Month]

Alco$TotalS<- as.numeric(gsub(",", "", Alco$TotalS))

egen<- egen |> pivot_longer(cols = 3:62, names_to = "Month", values_to = "net_gen")

egen<- egen |> filter(egen$X. != "Net generation-all primemovers-all fuels")

egen<- egen |> group_by(Month) |> summarise(`Normal Capacity` = sum(as.numeric(net_gen), na.rm=TRUE))

egen<- separate(egen, Month, into = c("Month", "Year"), sep="\\.")

wtemp<- separate(wtemp, Date, into = c("Year", "Month", "Day"), sep="\\/")

#Gen and Consumption
MWcap_py<- 14519034/1000*(365*24)

barcont<- c(
  sum(egen$`Normal Capacity`[egen$Year=="2020"])/MWcap_py,
  sum(egen$`Normal Capacity`[egen$Year=="2021"])/MWcap_py,
  sum(egen$`Normal Capacity`[egen$Year=="2022"])/MWcap_py,
  sum(egen$`Normal Capacity`[egen$Year=="2023"])/MWcap_py,
  sum(egen$`Normal Capacity`[egen$Year=="2024"])/MWcap_py)

barcont<- mean(barcont)

consume_py<- Alco |> group_by(Year) |> summarise(Consumed_Per_Year = sum(as.numeric(gsub(",", "", TotalS)), na.rm = TRUE))

consume_py$Consumed_Per_Year<- consume_py$Consumed_Per_Year/MWcap_py

contbybar<- consume_py
contbybar$Consumed_Per_Year<- consume_py$Consumed_Per_Year * barcont
mean(contbybar$Consumed_Per_Year)

egen$consump<- Alco$TotalS* contbybar$Consumed_Per_Year
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

avgin<- wtemp |> group_by(Year, Month)
avgin<- avgin |> summarise(Mean_Temp = mean(Water.Temp...F.))
