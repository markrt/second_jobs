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
