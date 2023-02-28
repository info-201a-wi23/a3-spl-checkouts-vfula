library("dplyr")
library("ggplot2")
library("scales")
library("knitr")
library("stringr")
library("plotly")

# Get the following values for report:
sum_df <- spl_data %>% 
  filter(str_detect(Subjects, "drama|motion picture")) %>% 
  filter(str_detect(Title, "pacific rim"))

sum_df$Title <- sub('\\.','', sum_df$Title)
sum_df$Title[str_detect(sum_df$Subjects, "end of the world")] <- "Pacific Rim"
sum_df$Title[str_detect(sum_df$Subjects, "motion picture music")] <- "Pacific Rim: Uprising Soundtrack"
sum_df$Title[str_detect(sum_df$Subjects, "special effects")] <- "Pacific Rim: Man, Machines & Monsters: The Inner Workings of an Epic Film"
sum_df$Title[str_detect(sum_df$Title, "uprising")] <- "Pacific Rim: Uprising"

max_checkout <- sum_df %>% 
  filter(Checkouts == max(Checkouts, na.rm = TRUE)) %>% 
  pull(Checkouts)

max_checkout_date <- sum_df %>% 
  filter(Checkouts == max(Checkouts, na.rm = TRUE)) %>% 
  pull(date)

max_checkout_name <- sum_df %>% 
  filter(Checkouts == max(Checkouts, na.rm = TRUE)) %>% 
  pull(Title)

max_checkout_type <- sum_df %>% 
  filter(Checkouts == max(Checkouts, na.rm = TRUE)) %>% 
  pull(MaterialType)

min_checkout <- sum_df %>% 
  filter(Checkouts == min(Checkouts, na.rm = TRUE)) %>% 
  pull(Checkouts)

min_checkout_date <- sum_df %>% 
  filter(Checkouts == min(Checkouts, na.rm = TRUE)) %>% 
  pull(date)

min_checkout_name <- sum_df %>% 
  filter(Checkouts == min(Checkouts, na.rm = TRUE)) %>% 
  pull(Title)

min_checkout_type <- sum_df %>% 
  filter(Checkouts == min(Checkouts, na.rm = TRUE)) %>% 
  pull(MaterialType)

most_recent_checkout_name <- sum_df %>% 
  filter(date == max(date, na.rm = TRUE)) %>% 
  pull(Title)

most_recent_checkout_date <- sum_df %>% 
  filter(date == max(date, na.rm = TRUE)) %>% 
  pull(date)



unique_mat_types <- length(unique(sum_df$MaterialType))

# Add all variables into a summary info list:
summary <- list()
summary$max_checkout <- max_checkout
summary$max_checkout_date <- max_checkout_date
summary$max_checkout_name <- max_checkout_name
summary$max_checkout_type <- max_checkout_type

summary$min_checkout <- min_checkout
summary$min_checkout_date <- min_checkout_date
summary$min_checkout_name <- min_checkout_name
summary$min_checkout_type <- min_checkout_type

summary$most_recent_checkout_name <- most_recent_checkout_name
summary$most_recent_checkout_date <- most_recent_checkout_date
summary$sum_df <- sum_df
summary$unique_mat_types <- unique_mat_types