### making figure 1 for the Giuliana etc paper

# loading packages
library(tidyverse)
library(scales)

# data

data <- 
  data.frame(
  stringsAsFactors = FALSE,
         first_job = c("Creative (core): 3%",
                       "Creative (non-core): 3%","IT: 2%","Professional (other): 43%",
                       "Other: 49%","Total"),
     core_creative = c(13L, 14L, 7L, 7L, 5L, 6L),
          non_core = c(4L, 25L, 14L, 4L, 3L, 4L),
                it = c(0L, 6L, 55L, 8L, 2L, 6L),
              prof = c(40L, 26L, 21L, 52L, 17L, 33L),
             other = c(44L, 29L, 3L, 29L, 73L, 51L)
)

data <- 
  data %>% 
  pivot_longer(core_creative:other) %>% 
  mutate(name = factor(name,
                       levels = c("core_creative",
                                  "non_core",
                                  "it",
                                  "prof",
                                  "other"))) %>% 
  mutate(name = 
           fct_recode(name,
                      "Creative (core)" = 
                        "core_creative",
                      "Creative (non-core)" = 
                        "non_core",
                      "IT" = 
                        "it",
                      "Professional (other)" = 
                        "prof",
                      "Other" = 
                        "other")) %>% 
  mutate(value = value/100)

data$highlight <- 
  c("yes",
    "no",
    "no",
    "no",
    "no",
    "no",
    "no",
    "yes",
    "no",
    "no",
    "no",
    "no",
    "no",
    "no",
    "yes",
    "no",
    "no",
    "no",
    "no",
    "no",
    "no",
    "yes",
    "no",
    "no",
    "no",
    "no",
    "no",
    "no",
    "yes",
    "no"
  )

data %>% 
  ggplot() +
  aes(x = value,
      y = fct_rev(name),
      label = value*100,
      fill = highlight) +
  geom_col() +
  geom_text(hjust = 0,
            nudge_x = .05) +
  facet_wrap(~ first_job) +
  labs(x = "",
       y = "") +
  scale_fill_manual(values = c("gray70",
                               "black")) +
  theme_minimal() +
  theme(legend.position = "none") +
  theme(panel.grid.minor = element_blank()) +
  scale_x_continuous(labels = percent) 
