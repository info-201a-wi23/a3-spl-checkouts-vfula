# Chart 1: Pacific Rim movies and art book checkouts over time
# Veronica Fula

library("dplyr")
library("ggplot2")
library("stringr")
library("scales")

# Dataframe of only Pacific Rim media, scrubbed
pr_df <- spl_data %>% 
  filter(str_detect(Subjects, "drama|motion picture")) %>% 
  filter(str_detect(Title, "pacific rim"))

pr_df$Title <- sub('\\.','', pr_df$Title)
pr_df$Title[str_detect(pr_df$Subjects, "end of the world")] <- "Pacific Rim"
pr_df$Title[str_detect(pr_df$Subjects, "motion picture music")] <- "Pacific Rim: Uprising Soundtrack"
pr_df$Title[str_detect(pr_df$Subjects, "special effects")] <- "Pacific Rim: Man, Machines & \nMonsters: The Inner Workings \nof an Epic Film"
pr_df$Title[str_detect(pr_df$Title, "uprising")] <- "Pacific Rim: Uprising"

# Plot graph
pacrim_checkout_graph <- ggplot(data = pr_df) + 
  geom_line(aes(x = date, y = Checkouts, color = Title)) +
  scale_color_brewer(palette = "Set1") +
  
  # Add title and axis labels
  labs(
    title = "Pacific Rim Media Checkouts 2013 - 2023", # plot title
    x = "Date", # x-axis label
    y = "Number of Checkouts", # y-axis label
    color = "Item" # legend label for the "color" property
  )
