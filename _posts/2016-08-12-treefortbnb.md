---
layout:  post
title: "The Priceonomics Data Puzzle: TreefortBnb"
date: "2016-08-10 00:00:00""
comments:  false
published:  true
author: "Cyrus M"
categories: [R]
date:
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

Basic listed prices, however, may not reflect **actual** rental costs because not all advertised listings are actually rented out. One way to identify median rental prices for listings that have actually been rented is to subset the data to include only those listings with reviews. The working assumption here is that listings with no reviews may never have actually been rented. For listings with at least one review, Carmel CA, Malibu CA, and Incline Village NV are the most expensive by median rental price.


{% highlight r %}
#Read in data and aggregate # of units by city and subset to top 100
df1.b <- url %>%
  read.csv(col.names=c("ID","City","State","Price","Reviews")) %>%
  subset(Reviews > 0) %>% #subset to only include reviewed listings
  group_by(State, City) %>%
  summarize(Unit_Sum=n()) %>% 
  arrange(desc(Unit_Sum)) %>%
  head(100) 

#Read in data again and obtain median rental price by city
df2.b <- url %>%
  read.csv(col.names=c("ID","City","State","Price","Reviews")) %>%
  subset(Reviews > 0) %>% #subset to only include reviewed listings
  group_by(State, City) %>%
  summarize(Price_Median=median(Price)) %>%
  arrange(desc(Price_Median)) 

#Merge two data frames
df3.b <-merge(df1.b, df2.b, by=c("City", "State"), all.x=TRUE, all.y=FALSE)
df3.b<-arrange(df3.b, desc(Price_Median))

#Rename columns
colnames(df3.b)[3]<-"Unit Total"
colnames(df3.b)[4]<-"Median Price"

#Produce output table in html
df3.b<-head(df3.b, 10)
formattable(df3.b, list(
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
   <td style="text-align:right;"> Carmel </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 100.00%">300.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Malibu </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 75.00%">225.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Incline Village </td>
   <td style="text-align:right;"> NV </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 66.67%">200.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Laguna Beach </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 66.67%">200.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Truckee </td>
   <td style="text-align:right;"> NV </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 66.67%">200.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Napa </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 61.50%">184.5</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Park City </td>
   <td style="text-align:right;"> UT </td>
   <td style="text-align:right;"> 101 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 59.67%">179.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Sunny Isles Beach </td>
   <td style="text-align:right;"> FL </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 59.17%">177.5</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> Sonoma </td>
   <td style="text-align:right;"> CA </td>
   <td style="text-align:right;"> 92 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 58.33%">175.0</span> </td>
  </tr>
  <tr>
   <td style="text-align:right;"> New York </td>
   <td style="text-align:right;"> NY </td>
   <td style="text-align:right;"> 5597 </td>
   <td style="text-align:right;"> <span style="display: inline-block; direction: rtl; border-radius: 4px; padding-right: 2px; background-color: orange; width: 55.00%">165.0</span> </td>
  </tr>
</tbody>
</table>

## Let's Map it!

Let's see if these rental prices cluster by location across the lower 48 states. Using a function I wrote based on Microsoft's Bing's API, I've managed to batch geocode the locations provided in the TreefortBnb data file.


  

{% highlight r %}
#Load Dependencies
library(ggplot2)
library(cowplot)

#Batch geocode
options(BingMapsKey="AtquMkrNaB7ME7krIpwQgrTwEqwB0HbUEpRKb9wfpBW-xCbgBzrGabEyUGkdpO0G")
df3$Location<-paste(df3$City, df3$State, sep = ", ")
df30<-t(geocodeVect(df3$Location, service="bing", returntype="coordinates"))
df10<-as.data.frame(df30)
colnames(df10)<-c("lat","lon")
df3<-cbind(df3, df10)
df3<-as.data.frame(df3)

#Subset to only include lower 48
df3<- df3 %>%
  subset(State!="HI") %>%
  subset(State!="AK")
row.names(df3) <- NULL 

states <- map_data("state")
states <- states[order(states$order), ]

ggplot() +
  geom_polygon(data=states, aes(long, lat, group=group),
               size=0.1,fill="black", color="white", alpha=0.75) +
  geom_point(data=df3, aes(lon, lat, size= `Median Price`), 
             color="blue", alpha=0.5) +
  geom_point(data=df3, shape = 1, 
             aes(lon, lat, size=`Median Price`), 
             colour = "white", alpha=0.7) +
   theme(axis.line=element_blank(),
         axis.text.x=element_blank(),
         axis.text.y=element_blank(),
         axis.ticks=element_blank(),
         axis.title.x=element_blank(),
         axis.title.y=element_blank(),
         legend.position="bottom",
         panel.background=element_blank(),
         panel.border=element_blank(),
         panel.grid.major=element_blank(),
         panel.grid.minor=element_blank(),
         plot.background=element_blank())
{% endhighlight %}

<img src="/blog/figure/source/2016-08-12-treefortbnb/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto 0 auto auto;" />

As a final exercise, let's compare median AirBnb prices to median TreefortBnb prices. To accomplish that, I've scraped data from Priceonomics's online AirBnb to hotel comparison table. Unfortunately, the data on AirBnb rental prices is not as exhaustive as the data for TreefortBnb (less populated locations are missing for AirBnb), thus, I've restricted my analysis to the top 25 most rented locations for TreefortBnb in an effort to increase the overlap between the two samples. Data on AirBnb  rental prices for cities on the TreeforBnb list but not on Priceonomics's list of AirBnb prices I've imputed using data drawn from current averages for each location as shown on AirBnb's own website (I used this method for 5 cities: Brooklyn, Queens, Kissimmee, Miami Beach, and Santa Monica).

The graph below shows the first difference between TreefortBnb and AirBnb median rental prices across the 25 busiest TreefortBnb cities across the US. Negative values indicate locations where median AirBnb rental prices are more expensive than their TreefortBnb counterparts. Queens, NY (highlighted in red) is the only location where median prices are equivalent, although, median prices in Washington DC, Boulder, CO, and Denver, CO are very close. 




{% highlight r %}
# Load dependencies
library(jsonlite)
library(data.table)

# Scrape data from site
appData <- fromJSON("http://priceonomics.com/static/js/hotels/all_data.json")

# replicate table
data2 <- data.frame(City = names(appData), Price = sapply(appData, function(x) x$air$apt$p), 
    stringsAsFactors = FALSE)

# Arrange data
setDT(data2)
data2 <- data2[order(Price, decreasing = TRUE)]
data2 <- as.data.frame(data2)
colnames(data2) <- c("Location", "AirPrice")

# Subset to only include 25 busiest tree fort markets
dddd <- df3
colnames(dddd)[3] <- "UnitTotal"
data3 <- arrange(dddd, desc(UnitTotal))
data3 <- head(data3, 25)

# Imput missing AirBnb values
data4 <- merge(data3, data2, by = "Location", all.x = TRUE, all.y = FALSE)
data4$AirPrice <- as.character(data4$AirPrice)
data4[6, 8] <- 104
data4[10, 8] <- 172
data4[13, 8] <- 158
data4[20, 8] <- 99
data4[23, 8] <- 141
colnames(data4)[5] <- c("PriceMedian")
data4$PriceMedian <- as.numeric(data4$PriceMedian)
data4$AirPrice <- as.numeric(data4$AirPrice)

# Generate first difference
data4$first_diff <- data4$PriceMedian - data4$AirPrice  #Negative value 
# mean AirBnb more expensive - positive means TreefortBnb is more
# expensive

# Create variable distinguishing neg from pos values of 1st difference
data4$abs_first_diff <- abs(data4$first_diff)
data4$Air_pricier <- ifelse(data4$first_diff < 0, 0, 1)
data4$Air_pricier <- as.factor(data4$Air_pricier)

# Plot
library(cowplot)  #theme
a <- ifelse(data4$first_diff < 1, ifelse(data4$Air_pricier != 0, "red", 
    "darkgrey"), "blue")
ggplot(data4, aes(x = Location, y = first_diff)) + geom_bar(stat = "identity", 
    aes(fill = Air_pricier)) + ylab("First Difference") + xlab("") + theme(axis.text.x = element_text(angle = 35, 
    hjust = 1)) + theme(axis.text.x = element_text(colour = a, size = 10)) + 
    scale_fill_manual(values = c("darkgrey", "darkblue")) + theme(legend.position = "none", 
    panel.background = element_blank())
{% endhighlight %}

<img src="/blog/figure/source/2016-08-12-treefortbnb/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />


