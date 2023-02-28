# Chart 3: Stacked bar chart of Pacific Rim media checkouts over time
# Veronica Fula

library("dplyr")
library("ggplot2")
library("stringr")
library("scales")

# Dataframe of Legendary data, scrubbed
legendary_df <- spl_data %>% 
  filter(str_detect(Subjects, "science fiction|greek|dinosaur|batman|imaginary|wall|china")) %>% 
  filter(str_detect(Title, "legendary pictures"))
legendary_df <- legendary_df %>% 
  filter(!str_detect(Title, 'dracula|10,000|clash|wrath|batman|wall|rises|dark'))

legendary_df$Title <- sub('\\.','', legendary_df$Title)
legendary_df$Title <- stringr::str_trunc(legendary_df$Title, 43)
legendary_df$Title[str_detect(legendary_df$Subjects, "end of the world")] <- "Pacific Rim"
legendary_df$Title[str_detect(legendary_df$Title, "uprising")] <- "Pacific Rim: Uprising"
legendary_df$Title[str_detect(legendary_df$Subjects, "king kong")] <- "Godzilla vs. Kong"
legendary_df$Title[str_detect(legendary_df$Title, "of the monsters")] <- "Godzilla: King of the Monsters"
legendary_df$Title[str_detect(legendary_df$Subjects, "dreams")] <- "Inception"
legendary_df$Title[str_detect(legendary_df$Subjects, "interplanetary")] <- "Interstellar"
legendary_df$Title[str_detect(legendary_df$Title, "jurassic world")] <- "Jurassic World"
legendary_df$Title[str_detect(legendary_df$Subjects, "volcanoes")] <- "Jurassic World: Fallen Kingdom"
legendary_df$Title[str_detect(legendary_df$Subjects, "imaginary")] <- "Warcraft"

# Plot graph
stacked_checkout_graph <- ggplot(data = legendary_df, aes(fill=Title, y=Checkouts, x=CheckoutYear)) + 
  geom_bar(position="stack", stat="identity") +
  scale_color_brewer(palette = "Set1") +
  
  # Add title and axis labels
  labs(
    title = "Legendary Pictures Yearly Checkouts 2013 - 2023", # plot title
    x = "Date", # x-axis label
    y = "Number of Checkouts", # y-axis label
    color = "Item" # legend label for the "color" property
  )
