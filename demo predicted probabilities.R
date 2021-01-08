### illustrating what i had in mind
# for plotting predicted probabilities

data_2 <- 
  data.frame(
  stringsAsFactors = FALSE,
             Profile = c("Age 23, female, GCSEs",
                         "Age 23, female, degree","Age 23, male, GCSEs",
                         "Age 23, male, degree","Age 55, female, GCSEs",
                         "Age 55, female, degree","Age 55, male, GCSEs",
                         "Age 55, male, degree","Age 23, female, GCSEs","Age 23, female, degree",
                         "Age 23, male, GCSEs","Age 23, male, degree",
                         "Age 55, female, GCSEs","Age 55, female, degree",
                         "Age 55, male, GCSEs","Age 55, male, degree",
                         "Age 23, female, GCSEs","Age 23, female, degree","Age 23, male, GCSEs",
                         "Age 23, male, degree","Age 55, female, GCSEs",
                         "Age 55, female, degree","Age 55, male, GCSEs",
                         "Age 55, male, degree"),
             Outcome = c("One job","One job",
                         "One job","One job","One job","One job","One job",
                         "One job","Portfolio","Portfolio","Portfolio",
                         "Portfolio","Portfolio","Portfolio","Portfolio","Portfolio",
                         "Juggler","Juggler","Juggler","Juggler","Juggler",
                         "Juggler","Juggler","Juggler")
  )

data_2$prob <- 
  rnorm(24, mean = .1, sd = .05)

ggplot(data_2) +
  aes(x = prob,
      y = Outcome,
      label = round(prob * 100)) +
  geom_col() +
  facet_wrap(~ Profile,
             ncol = 2) +
  scale_x_continuous(labels = percent) +
  labs(x = "",
       y = "",
       title = "Predicted probability of each outcome \nholding other values at their means") +
  theme_minimal()




#### do it again with real data
library(tidyverse)
library(patchwork)
library(scales)

probabilities <- 
  data.frame(
  stringsAsFactors = FALSE,
           Outcome = c("One creative job",
                       "One creative job","One creative job","One creative job",
                       "One creative job","One creative job","One creative job",
                       "One creative job","Portfolio","Portfolio","Portfolio",
                       "Portfolio","Portfolio","Portfolio","Portfolio",
                       "Portfolio","Juggler","Juggler","Juggler","Juggler",
                       "Juggler","Juggler","Juggler","Juggler","Side hustler",
                       "Side hustler","Side hustler","Side hustler","Side hustler",
                       "Side hustler","Side hustler","Side hustler"),
               Age = c(23L,23L,23L,23L,55L,55L,
                       55L,55L,23L,23L,23L,23L,55L,55L,55L,55L,23L,23L,
                       23L,23L,55L,55L,55L,55L,23L,23L,23L,23L,55L,
                       55L,55L,55L),
            Gender = c("Male","Male","Female",
                       "Female","Male","Male","Female","Female","Male","Male",
                       "Female","Female","Male","Male","Female","Female",
                       "Male","Male","Female","Female","Male","Male",
                       "Female","Female","Male","Male","Female","Female","Male",
                       "Male","Female","Female"),
            Degree = c("No degree","Degree",
                       "No degree","Degree","No degree","Degree","No degree",
                       "Degree","No degree","Degree","No degree","Degree",
                       "No degree","Degree","No degree","Degree","No degree",
                       "Degree","No degree","Degree","No degree","Degree",
                       "No degree","Degree","No degree","Degree","No degree",
                       "Degree","No degree","Degree","No degree","Degree"),
              Pred = c(0.8073951,0.8255761,0.8081565,
                       0.8367164,0.822594,0.8416192,0.8205625,0.8493768,
                       0.0080491,0.0100256,0.0019276,0.0024375,0.009516,
                       0.0118542,0.0022754,0.0028777,0.0599567,0.0695498,
                       0.0356695,0.0419299,0.0466805,0.0541975,0.0276524,
                       0.0325095,0.1245991,0.0948484,0.1542464,0.1189162,0.1212095,
                       0.0923291,0.1495097,0.115236),
                SE = c(0.0014118,0.0011089,0.0014726,
                       0.0010088,0.0010814,0.0008684,0.0012567,0.0008891,
                       0.0003936,0.0003448,0.0001144,0.0001129,0.0003112,
                       0.0002691,0.0001118,0.0001188,0.0009052,0.0008131,
                       0.0006086,0.0005436,0.000594,0.0005605,0.0004363,
                       0.0004161,0.0011416,0.0007884,0.0013915,0.0008873,0.0009176,
                       0.0006674,0.0012055,0.0008043),
                 z = c(571.87,744.5,548.79,829.41,
                       760.65,969.18,652.94,955.36,20.45,29.07,16.85,
                       21.59,30.58,44.05,20.35,24.22,66.24,85.53,58.61,77.13,
                       78.59,96.69,63.39,78.14,109.14,120.3,110.85,
                       134.01,132.1,138.33,124.02,143.28),
                 p = c(0L,0L,0L,0L,0L,0L,0L,0L,
                       0L,0L,0L,0L,0L,0L,0L,0L,0L,0L,0L,0L,0L,0L,
                       0L,0L,0L,0L,0L,0L,0L,0L,0L,0L),
                lb = c(0.804628,0.8234027,0.8052702,
                       0.8347391,0.8204744,0.8399172,0.8180994,0.8476343,
                       0.0072777,0.0093497,0.0017034,0.0022162,0.0089061,
                       0.0113268,0.0020563,0.0026448,0.0581825,0.0679562,
                       0.0344767,0.0408644,0.0455164,0.0530989,0.0267974,
                       0.0316941,0.1223615,0.0933031,0.1515192,0.1171771,0.1194111,
                       0.091021,0.1471469,0.1136596),
                ub = c(0.8101623,0.8277495,0.8110428,
                       0.8386936,0.8247136,0.8433212,0.8230257,0.8511193,
                       0.0088205,0.0107015,0.0021518,0.0026588,0.0101259,
                       0.0123816,0.0024946,0.0031105,0.0617308,0.0711435,
                       0.0368622,0.0429954,0.0478447,0.0552962,0.0285074,
                       0.033325,0.1268366,0.0963938,0.1569736,0.1206554,0.1230079,
                       0.0936373,0.1518725,0.1168123)
) %>% 
  mutate(Outcome = 
           factor(Outcome,
                  levels = c("Portfolio",
                             "Juggler",
                             "Side hustler")))

younger <- 
  probabilities %>%
  filter(Outcome != "One creative job") %>% 
  filter(Age == 23) %>% 
  ggplot() +
  aes(x = Pred,
      y = Outcome) +
  geom_col(width = .5) +
  geom_label(aes(label = round(Pred, 3)),
            hjust = 0,
            nudge_x = 0.005) +  
  facet_grid(Degree ~ Gender) +
  theme_minimal() +
  labs(subtitle = "Age 23",
       x = "",
       y = "") +
  theme(axis.text.x = element_blank())+
  xlim(0, .21)

older <- 
  probabilities %>%
  filter(Outcome != "One creative job") %>% 
  filter(Age == 55) %>% 
  ggplot() +
  aes(x = Pred,
      y = Outcome) +
  geom_col(width = .5) +
  geom_label(aes(label = round(Pred, 3)),
            hjust = 0,
            nudge_x = 0.005) +
  facet_grid(Degree ~ Gender) +
  theme_minimal() +
  labs(subtitle = "Age 55",
       x = "",
       y = "") +
  xlim(0, .21)

younger / older
