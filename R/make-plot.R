
library(tidyverse)

gg_data <- read_rds("data/votes-margin.rds") %>%
  mutate(state = reorder(state, votes_margin, min, na.rm = TRUE)) %>%
  mutate(label = paste0(year, "; ", scales::comma(votes_margin, accuracy = 1), " votes")) %>%
  mutate(label = ifelse(votes_margin < 1000, label, NA)) %>%
  glimpse()

ggplot(gg_data, aes(x = votes_margin, y = state)) + 
  geom_label_repel(aes(label = label), 
                   size = 2.0, point.padding = 1,
                   arrow = arrow(length = unit(0.01, "npc"))) + 
  geom_point(alpha = 0.5) + 
  scale_x_log10(label = scales::comma) + 
  theme_bw() + 
  labs(title = "Vote Margins in Presidential Elections, By State, 1976-2016", 
       x = "Margin of Victory in Votes",
       y = NULL)
ggsave("plot.png", height = 5, width = 8)
