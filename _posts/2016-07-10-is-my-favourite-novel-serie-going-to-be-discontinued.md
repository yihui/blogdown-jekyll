---
layout: post
title: Is My Favourite Novel Serie going to be discontinued?
---

Due to the change in the publishing industry in China, modern writters
generally have to establish themselve by publishing their novel online
and gain sufficient reputation before a publishing company approach and
offers a contract.

Simliar to celebrities, the writters are encourage to publish their work
on a daily basis to engage with their readers. Often 2 to 3 chapters are
posted a day, and sometimes even more if a fan donates a generous
amount.

I have been following this particular novel for several years, however,
recently I found the update to be much slower than before. There has
been discussions on the possibility that the series may be discontinued
due to the high level of stress.

So I decided to investigate the case, and hope not to find evidence that
my favourite series is going to be discontinued.

To do this, I scrapped the web page and extracted the time stamp of each
post. Then investigate the duration between sequetial posts to see if
there is any changes in the pattern.

Let's load the required libraries and define some helper functions.

    library(XML)
    library(stringr)
    library(magrittr)
    library(ggplot2)

    ## This function builds the url to a specific thread/novel
    buildUrl = function(thread, page){
        paste0("http://ck101.com/thread-", thread, "-", page, "-1.html")
    }

    ## This function extracts the time stamp from a given page
    extractTimeStampsFromPage = function(url){
        failed = TRUE
        while(failed){
            doc = htmlTreeParse(url, useInternalNodes = T)
            if(!inherits(doc, "try-error"))
                failed = FALSE
        }   
        time_stamp_text =
            xpathSApply(doc, '//span[@class="postDateLine"]/text()', xmlValue)

        time_stamps_char =
            unlist(
                lapply(time_stamp_text, FUN = function(x){
                    str_match(x, "[0-9]{4}\\-[0-9]+\\-[0-9]+.[0-9]{2}:[0-9]{2}")
                })
            )
        time_stamps = as.POSIXct(time_stamps_char, format = "%Y-%m-%d %H:%M")
        time_stamps
    }

    ## This function gets the current latest page of the novel
    getMaxPageNumber = function(url){
        failed = TRUE
        while(failed){
            doc = try(htmlTreeParse(url, useInternalNodes = T))
            if(!inherits(doc, "try-error"))
                failed = FALSE
        }
        last_page =
            xpathSApply(doc, '//a[@class="last"]/text()', xmlValue)
        as.numeric(gsub("[^0-9]", "", last_page[1]))
    }

    ## This function extracts all the time stamp of the novel
    extractNovelTimeStamps = function(thread){
        last_page = getMaxPageNumber(buildUrl(thread, "1"))
        lapply(1:last_page, FUN = function(x){
            current_page = buildUrl(thread, x)
            cat("Extracting page ", current_page, "\n")
            extractTimeStampsFromPage(current_page)
        }) %>%
            do.call("c", .)
    }

    ## Calculate the time differences in hour
    calculate_hour_diff = function(time_stamps){
        diff(time_stamps)/60/60
    }

After defining all the necessary helper function, we can start scrapping
the data for the analysis. There are three novels in this series, the
first two `do puo` and `wu dong` has been completed, and the third one
`da zhu zai` is in progress.

I have removed time difference that is less than 1 and greater than 168
hours which corresponds to a week. The reason to delete time stamps less
than an hour is due to the infrequent update on the forum of the first
novel where the author had yet to establish a firm reputation. While the
cap at 168 is for special chapters that were written many months after
the completion of the first two novels.

    da_zhu_zai_time_stamp = extractNovelTimeStamps("2762483")
    da_zhu_zai_time_diff = calculate_hour_diff(da_zhu_zai_time_stamp)
    da_zhu_zai_time_diff = da_zhu_zai_time_diff[da_zhu_zai_time_diff < 168]


    do_puo_time_stamp = extractNovelTimeStamps("1455308")
    do_puo_time_diff = calculate_hour_diff(do_puo_time_stamp)
    do_puo_time_diff = do_puo_time_diff[do_puo_time_diff < 168 & do_puo_time_diff > 1]

    wu_dong_time_stamp = extractNovelTimeStamps("1979168")
    wu_dong_time_diff = calculate_hour_diff(wu_dong_time_stamp)
    wu_dong_time_diff = wu_dong_time_diff[wu_dong_time_diff < 168]

    full_time_diff = c(do_puo_time_diff, wu_dong_time_diff, da_zhu_zai_time_diff)

Let's take a look at the time series plot, it appears that the average
interval for novel one and two were fairly consistent to be around 12
hours or 2 post a day, while the third novel has a steady increasing
trend approaching 40 hours (A really bad sign!).

    novel_time =
        data.frame(duration = full_time_diff,
                   post = c(c(1:length(do_puo_time_diff)),
                             c(1:length(wu_dong_time_diff)),
                             c(1:length(da_zhu_zai_time_diff))),
                   novel = c(rep("1.do_puo", length(do_puo_time_diff)),
                             rep("2.wu_dong", length(wu_dong_time_diff)),
                             rep("3.da_zhu_zai", length(da_zhu_zai_time_diff))))
               

    ggplot(data = novel_time, aes(x = post, y = duration)) +
        geom_line() +
        geom_smooth(col = "red", level = 0.99) + 
        facet_wrap(~novel)

    ## Don't know how to automatically pick scale for object of type difftime. Defaulting to continuous.

![](time_to_write_a_chapter_files/figure-markdown_strict/unnamed-chunk-3-1.png)<!-- -->

The summary table also shows the same result that the average or median
duration to write a new chapter has almost doubled in contrast to the
two predecessors.

    with(novel_time, tapply(duration, novel, summary))

    ## $`1.do_puo`
    ##   Length    Class     Mode 
    ##     1106 difftime  numeric 
    ## 
    ## $`2.wu_dong`
    ##   Length    Class     Mode 
    ##     1314 difftime  numeric 
    ## 
    ## $`3.da_zhu_zai`
    ##   Length    Class     Mode 
    ##     1277 difftime  numeric

This simple analysis shows that there are some possibliies that my
favourite novel will be discontinued. However, the third novel is also
expected to be much longer than the first two. So I hope the author may
be simply gathering and structuring his ideas, then regain his momentum
and finish the novel.
