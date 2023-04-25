library(rvest)
library(tidyverse)
library(readr)
library(ggplot2)


men100m_html  <- read_html("http://www.alltime-athletics.com/m_100ok.htm")
men100m_html |> html_nodes(xpath = "//pre") |> html_text() -> men100m_list
men100m_tbl  <- read_fwf(men100m_list)

# Change the names of the category in a tibble
# men100m_tibble = tibble(
#     total_rank = men100m_tbl$X1,
#     time_run = men100m_tbl$X2,
#     error = men100m_tbl$X3,
#     athlet_name = men100m_tbl$X4,
#     country_code = men100m_tbl$X5,
#     birthdate = men100m_tbl$X6,
#     match_rank = men100m_tbl$X7,
#     place = men100m_tbl$X8,
#     data_match = men100m_tbl$X9
# )

# Or passing through the data frame
men100m_tbl <- head(men100m_tbl, 3899)
names(men100m_tbl) <- c("total_rank", "time_run", "error", "athlet_name", "country_code", "birthdate", "match_rank", "place", "data_match")
# men100m_tibble = as_tibble(men100m_tbl)
# spec(men100m_tbl)


# Convert the type of the cathegories
men100m_tbl$birthdate <- as.Date(men100m_tbl$birthdate, "%d.%m.%Y")
men100m_tbl$data_match <- as.Date(men100m_tbl$data_match, "%d.%m.%Y")

# Solving the probllem of the letters at the end of the element in leaderbord
for (i in 1:length(men100m_tbl$time_run)) {
    stringa_divisa <- strsplit(men100m_tbl$time_run[i], "")[[1]]
    stringa_unita <- ""
    for (j in 1:length(stringa_divisa)){
        # print(paste(i, j, " poi ", stringa_divisa[j]))
        if (str_equal(stringa_divisa[j], "A") & !is.na(stringa_divisa[j])){
            stringa_divisa[j] <- ""
        }
        stringa_unita <- paste(stringa_unita, stringa_divisa[j], sep = "")
    }
    # print(stringa_unita)
    men100m_tbl$time_run[i] <- stringa_unita
}
men100m_tbl$time_run <- as.numeric(men100m_tbl$time_run)

# Doing the same for errors
men100m_tbl$error <- as.double(men100m_tbl$error)
men100m_tbl$error[is.na(men100m_tbl$error)] <- 0.0

# And for the match rank
for (i in 1:length(men100m_tbl$match_rank)) {
    stringa_divisa <- strsplit(men100m_tbl$match_rank[i], "")[[1]]
    men100m_tbl$match_rank[i] <- stringa_divisa[1]
}
men100m_tbl$match_rank <- as.numeric(men100m_tbl$match_rank)

# Doing it with the tibble method instead
# men100m_tibble %>% mutate_at(vars(time_run, error, match_rank), as.numeric)



# Plotting the required plots
# plot(men100m_tbl$data_match, men100m_tbl$time_run)

plot2_tibble = men100m_tbl %>% group_by("anno" = as.numeric(format(men100m_tbl$data_match, "%Y")), country_code) %>% summarize(n = n())
plot2_tibble = plot2_tibble  %>% group_by("anno" = plot2_tibble$anno) %>% summarise(m = max(n))

# plot(plot2_tibble$anno, plot2_tibble$m) # Histogram as scatter plot
barplot(plot2_tibble$m, names.arg=plot2_tibble$anno, ylim=c(0, max(plot2_tibble$m)), ylab="total number of people for the maximum country of the year", xlab="year")
axis(side=1,at=seq(min(plot2_tibble$anno),max(plot2_tibble$anno), 1))

# men100m_tbl$time_run <- as.double(men100m_tbl$time_run)
# men100m_tbl$time_run <- lapply(men100m_tbl$time_run, function(men100m_tbl) {
#     men100m_tbl$time_run <- ifelse(grepl(as.character(men100m_tbl$time_run[i]), "A", fixed=TRUE), unlist(strsplit(men100m_tbl$time_run[i], split="A", fixed=TRUE))[1], men100m_tbl$time_run)
#     return(men100m_tbl$time_run)
# })
# for (i in range(1, length(men100m_tbl$time_run))){
#     if (grepl(as.character(men100m_tbl$time_run[i]), "A", fixed=TRUE)) {
#         men100m_tbl$time_run[i] <<- substr(men100m_tbl$time_run[i], 1, nchar(men100m_tbl$time_run[i])-1)
#         unlist(strsplit(men100m_tbl$time_run[i], split="A", fixed=TRUE))[1]
#     }
#     if (is.na(men100m_tbl$time_run[i])){
#         men100m_tbl$time_run[i] = 0.0
#         cat("at ", i, " we found a NA", "\n")
#     }
# }
# men100m_tbl$time_run[is.na(men100m_tbl$time_run)] <-0
# men100m_tbl$time_run <- type_convert(df = men100m_tbl["time_run"], col_types = col_double())
# men100m_tbl$time_run <- as.Date(men100m_tbl$birthdate, "%d.%m.%Y")
