---
layout:  post
title: "The Priceonomics Data Puzzle: TreefortBnb"
comments:  false
published:  true
author: "Cyrus M"
categories: [R]
output:
  html_document:
    mathjax:  default
    fig_caption:  true
---

## Which Are the Most Expensive Cities in America to Book a Tree Fort?

It's the year 2020 and the sharing-economy is in full gear. Everything from hosting city dinners to ride-sharing the great outdoors is fair game. Capitalizing on their own interests and experience, eight-year-old startup prodigees, Sally Hershfield and Felicia Alvarez, have taken the sharing-economy by storm with their ever-growing TreefortBnB enterprise. 

Their nascent business venture has become such a hit that industry powerhouse AirBnb has not only taken notice but also action. They've identified markets where TreefortBnb has expanded most successfully and it's been rumored that AirBnb aims to undercut their marketshare by providing incentives that push their users to advertise more competitive prices. 

Using data obtained from Priceonomics, I've identified the median price of tree fort rentals for the top 100 cities with the most units on the market. Indianapolis IN, Malibu CA, and Park City UT are the most expensive cities in the US to rent a tree fort by median pricing, something AirBnb hopes to use to its own advantage by provding lower cost classical home alternatives.


{% highlight r %}
##Load Dependencies
library(pipeR)
library(dplyr)
library(formattable)

##URL to download data
url<-"https://s3.amazonaws.com/pix-media/Data+for+TreefortBnB+Puzzle.csv"

#Read in data and aggregate # of units by city and subset to top 100
df1 <- url %>%
  read.csv(col.names=c("ID","City","State","Price","Reviews")) %>%
  group_by(State, City) %>%
  summarize(Unit_Sum=n()) %>% 
  arrange(desc(Unit_Sum)) %>%
  head(100) 

#Read in data again and obtain median rental price by city
df2 <- url %>%
  read.csv(col.names=c("ID","City","State","Price","Reviews")) %>%
  group_by(State, City) %>%
  summarize(Price_Median=median(Price)) %>%
  arrange(desc(Price_Median)) 

#Merge two data frames
df3 <-merge(df1, df2, by=c("City", "State"), all.x=TRUE, all.y=FALSE)
df3<-arrange(df3, desc(Price_Median))

#Rename columns
colnames(df3)[3]<-"Unit Total"
colnames(df3)[4]<-"Median Price"

#Produce output table in html
formattable(df3, list(
  'Median Price' = color_bar("orange")))
{% endhighlight %}


<table class="table table-condensed">
 <thead>
  <tr>
   <th style="text-align:right;"> City </th>
   <th style="text-align:right;"> State </th>
   <th style="text-align:right;"> Unit Total </th>
   <th style="text-align:right;"> Median Price </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> Indianapolis </td>
   <td style="text-align:right;"> IN </td>
   <td style="text-align:right;"> 251 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 100.00%">650.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Malibu </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 92 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 46.77%">304.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Park City </td>
   <td style="text-align:right;"> UT </td>
   <td style="text-align:right;"> 229 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 46.00%">299.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Healdsburg </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 42.31%">275.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Truckee </td>
   <td style="text-align:right;"> NV </td>
   <td style="text-align:right;"> 67 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 42.31%">275.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Laguna Beach </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 41.31%">268.5</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Incline Village </td>
   <td style="text-align:right;"> NV </td>
   <td style="text-align:right;"> 118 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 39.85%">259.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Manhattan Beach </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 32.15%">209.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Charlotte </td>
   <td style="text-align:right;"> NC </td>
   <td style="text-align:right;"> 225 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 30.77%">200.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Napa </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 30.77%">200.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Sonoma </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 30.77%">200.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Austin </td>
   <td style="text-align:right;"> TX </td>
   <td style="text-align:right;"> 2836 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 30.62%">199.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> La Jolla </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 30.00%">195.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Sausalito </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 29.23%">190.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Hermosa Beach </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 48 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 29.15%">189.5</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Sunny Isles Beach </td>
   <td style="text-align:right;"> FL </td>
   <td style="text-align:right;"> 161 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 27.69%">180.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> New York </td>
   <td style="text-align:right;"> NY </td>
   <td style="text-align:right;"> 8043 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 26.15%">170.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Beverly Hills </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 74 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 24.62%">160.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Boston </td>
   <td style="text-align:right;"> MA </td>
   <td style="text-align:right;"> 613 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 24.62%">160.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Newport Beach </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 84 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 24.62%">160.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Marina del Rey </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 23.85%">155.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Venice </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 242 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 23.85%">155.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Louisville </td>
   <td style="text-align:right;"> KY </td>
   <td style="text-align:right;"> 86 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 23.08%">150.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Miami Beach </td>
   <td style="text-align:right;"> FL </td>
   <td style="text-align:right;"> 1345 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 23.08%">150.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Mill Valley </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 23.08%">150.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> New Orleans </td>
   <td style="text-align:right;"> LA </td>
   <td style="text-align:right;"> 833 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 23.08%">150.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> San Francisco </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 3622 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 23.08%">150.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Santa Monica </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 500 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 23.08%">150.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Miami </td>
   <td style="text-align:right;"> FL </td>
   <td style="text-align:right;"> 640 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 23.00%">149.5</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Taos </td>
   <td style="text-align:right;"> NM </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 22.85%">148.5</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Sebastopol </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 22.31%">145.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> San Diego </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 986 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 20.00%">130.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Scottsdale </td>
   <td style="text-align:right;"> AZ </td>
   <td style="text-align:right;"> 121 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 19.85%">129.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Washington </td>
   <td style="text-align:right;"> DC </td>
   <td style="text-align:right;"> 1402 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 19.85%">129.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> West Hollywood </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 229 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 19.85%">129.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Cambridge </td>
   <td style="text-align:right;"> MA </td>
   <td style="text-align:right;"> 300 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 19.23%">125.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Charleston </td>
   <td style="text-align:right;"> SC </td>
   <td style="text-align:right;"> 84 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 19.23%">125.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Las Vegas </td>
   <td style="text-align:right;"> NV </td>
   <td style="text-align:right;"> 291 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 19.23%">125.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Naples </td>
   <td style="text-align:right;"> FL </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 19.23%">125.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> San Rafael </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 19.23%">125.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Santa Cruz </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 127 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 19.23%">125.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Anchorage </td>
   <td style="text-align:right;"> AK </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 19.00%">123.5</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Brookline </td>
   <td style="text-align:right;"> MA </td>
   <td style="text-align:right;"> 47 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 18.46%">120.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Palo Alto </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 18.46%">120.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Santa Rosa </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 18.46%">120.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Hollywood </td>
   <td style="text-align:right;"> FL </td>
   <td style="text-align:right;"> 150 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 17.77%">115.5</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Colorado Springs </td>
   <td style="text-align:right;"> CO </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 17.38%">113.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Davenport </td>
   <td style="text-align:right;"> FL </td>
   <td style="text-align:right;"> 108 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 17.38%">113.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Mountain View </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 17.38%">113.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Brooklyn </td>
   <td style="text-align:right;"> NY </td>
   <td style="text-align:right;"> 4368 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 16.92%">110.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Kissimmee </td>
   <td style="text-align:right;"> FL </td>
   <td style="text-align:right;"> 266 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 16.92%">110.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Los Angeles </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 3236 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 16.92%">110.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Savannah </td>
   <td style="text-align:right;"> GA </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 16.46%">107.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Arlington </td>
   <td style="text-align:right;"> VA </td>
   <td style="text-align:right;"> 214 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 16.38%">106.5</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Paris </td>
   <td style="text-align:right;"> RI </td>
   <td style="text-align:right;"> 48 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 16.23%">105.5</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Honolulu </td>
   <td style="text-align:right;"> HI </td>
   <td style="text-align:right;"> 363 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 16.15%">105.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Alexandria </td>
   <td style="text-align:right;"> VA </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 16.08%">104.5</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Berkeley </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 328 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 15.38%">100.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Boulder </td>
   <td style="text-align:right;"> CO </td>
   <td style="text-align:right;"> 265 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 15.38%">100.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Carlsbad </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 54 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 15.38%">100.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Chicago </td>
   <td style="text-align:right;"> IL </td>
   <td style="text-align:right;"> 1255 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 15.38%">100.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Fort Lauderdale </td>
   <td style="text-align:right;"> FL </td>
   <td style="text-align:right;"> 151 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 15.38%">100.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Houston </td>
   <td style="text-align:right;"> TX </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 15.38%">100.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Long Beach </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 113 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 15.38%">100.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Philadelphia </td>
   <td style="text-align:right;"> PA </td>
   <td style="text-align:right;"> 457 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 15.38%">100.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> San Jose </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 104 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 15.38%">100.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Seattle </td>
   <td style="text-align:right;"> WA </td>
   <td style="text-align:right;"> 824 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 15.38%">100.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Somerville </td>
   <td style="text-align:right;"> MA </td>
   <td style="text-align:right;"> 99 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 15.38%">100.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Tampa </td>
   <td style="text-align:right;"> FL </td>
   <td style="text-align:right;"> 78 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 15.38%">100.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Pasadena </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 86 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 15.31%">99.5</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Queens </td>
   <td style="text-align:right;"> NY </td>
   <td style="text-align:right;"> 457 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 15.23%">99.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Ann Arbor </td>
   <td style="text-align:right;"> MI </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 15.08%">98.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Minneapolis </td>
   <td style="text-align:right;"> MN </td>
   <td style="text-align:right;"> 138 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 15.08%">98.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Long Island City </td>
   <td style="text-align:right;"> NY </td>
   <td style="text-align:right;"> 190 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 14.69%">95.5</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Glendale </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 13.85%">90.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Oakland </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 434 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 13.85%">90.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Tucson </td>
   <td style="text-align:right;"> AZ </td>
   <td style="text-align:right;"> 195 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 13.85%">90.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Salt Lake City </td>
   <td style="text-align:right;"> UT </td>
   <td style="text-align:right;"> 140 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 13.77%">89.5</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Atlanta </td>
   <td style="text-align:right;"> GA </td>
   <td style="text-align:right;"> 302 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 13.69%">89.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Dallas </td>
   <td style="text-align:right;"> TX </td>
   <td style="text-align:right;"> 114 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 13.38%">87.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Denver </td>
   <td style="text-align:right;"> CO </td>
   <td style="text-align:right;"> 283 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 13.23%">86.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Eugene </td>
   <td style="text-align:right;"> OR </td>
   <td style="text-align:right;"> 78 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 13.08%">85.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Jersey City </td>
   <td style="text-align:right;"> NJ </td>
   <td style="text-align:right;"> 82 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 13.08%">85.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Madison </td>
   <td style="text-align:right;"> WI </td>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 13.08%">85.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Phoenix </td>
   <td style="text-align:right;"> AZ </td>
   <td style="text-align:right;"> 167 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 13.08%">85.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Providence </td>
   <td style="text-align:right;"> RI </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 13.08%">85.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Baltimore </td>
   <td style="text-align:right;"> MD </td>
   <td style="text-align:right;"> 137 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 12.31%">80.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Nashville </td>
   <td style="text-align:right;"> TN </td>
   <td style="text-align:right;"> 185 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 12.31%">80.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Pittsburgh </td>
   <td style="text-align:right;"> PA </td>
   <td style="text-align:right;"> 99 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 12.31%">80.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> San Antonio </td>
   <td style="text-align:right;"> TX </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 12.31%">80.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Portland </td>
   <td style="text-align:right;"> OR </td>
   <td style="text-align:right;"> 819 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 12.15%">79.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Albuquerque </td>
   <td style="text-align:right;"> NM </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 11.54%">75.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Bronx </td>
   <td style="text-align:right;"> NY </td>
   <td style="text-align:right;"> 113 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 11.54%">75.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> New Haven </td>
   <td style="text-align:right;"> CT </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 11.54%">75.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Orlando </td>
   <td style="text-align:right;"> FL </td>
   <td style="text-align:right;"> 116 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 11.54%">75.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Silver Spring </td>
   <td style="text-align:right;"> MD </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 11.54%">75.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Cincinnati </td>
   <td style="text-align:right;"> OH </td>
   <td style="text-align:right;"> 47 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 10.77%">70.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Sacramento </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 57 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 10.00%">65.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Durham </td>
   <td style="text-align:right;"> NC </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 9.23%">60.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Raleigh </td>
   <td style="text-align:right;"> NC </td>
   <td style="text-align:right;"> 57 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 9.23%">60.0</span> </td>
  </tr>
</tbody>
</table>




