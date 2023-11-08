library(tidyverse)
library(ICplots)
library(extrafont)
font_import()

fy19fy22<-read_csv("nationwide-drugs-fy19-fy22.csv")
fy20fy23<-read_csv("nationwide-drugs-fy20-fy23.csv")

fy19<-fy19fy22%>%filter(FY=="2019" & Region=="Southwest Border" & `Drug Type` == "Fentanyl")
rm(fy19fy22)
fy20fy23<-fy20fy23%>%filter(Region=="Southwest Border" & `Drug Type`=="Fentanyl")

fy19fy23<-rbind(fy19,fy20fy23)
sumfy19fy23<-fy19fy23%>%group_by(FY)%>%summarise(
  total=sum(`Sum Qty (lbs)`)
)

write_csv(fy19fy23,"fentanylfy19fy23.csv")
fy18<-tibble()

plot<-ggplot(sumfy19fy23,aes(x=FY,y=total/1000))+
  geom_col(fill="#b70039")+
  labs(title="Cocaine Seized at US-Mexico border (FY19–FY23)",
       y="Quantity (thousands of pounds)",
       x="Fiscal Year")+
  theme_ic()

finalise_plot(plot,
              source_name="November, 2023\nSource: US Customs and Border Protection (CBP)",
              save_filepath = "fentanylfy19fy23.png")
