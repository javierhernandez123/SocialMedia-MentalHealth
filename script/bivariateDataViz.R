# __________________________________________________

# ---- BIVARIATE GRAPHS ----
# __________________________________________________

# ==== categorical explanatory, categorical response ====
ggplot(data=myData) +
  stat_summary(aes(x=CategExplanatoryVar, 
                   y=CategResponseVar),
               fun.y=mean, 
               geom="bar")+
  ggtitle("Descriptive Title Here")

# __________________________________________________

# ==== categorical explanatory, quantitative response ====

## bar graph
ggplot(data=myData) +
  stat_summary(aes(x=CategExplanatoryVar,
                   y=QuantResponseVar), 
               fun.y=mean, 
               geom="bar")

## boxplots
ggplot(data=myData) +
  geom_boxplot(aes(x=CategExplanatoryVar,
                   y=QuantResponseVar)) + 
  ggtitle("Descriptive Title Here")

## density plots
ggplot(data=myData) +
  geom_density(aes(x=QuantResponseVar,
                   color=CategExplanatoryVar)) + 
  ggtitle("Descriptive Title Here")

# __________________________________________________

# ==== quantitative explanatory, quantitative response ====
ggplot(data=myData) +
  geom_point(aes(x=QuantExplanatoryVar, 
                 y=QuantResponseVar)) +
  geom_smooth(aes(x=QuantExplanatoryVar, 
                  y=QuantResponseVar), 
              method="lm")

## Note, adding 3rd variable by using the color argument
ggplot(data=myData) +
  geom_point(aes(x=QuantExplanatoryVar, 
                 y=QuantResponseVar,
                 color=CategThirdVar)) +
  geom_smooth(aes(x=QuantExplanatoryVar, 
                  y=QuantResponseVar,
                  color=CategThirdVar), 
              method="lm")

# __________________________________________________

# ---- 3RD VARIABLE GRAPHS ----
# __________________________________________________

# ==== categorical explanatory, categorical response, categorical 3rd variable ====
tab1 <- ftable(myData$CategResponseVar,
               myData$CategExplanatoryVar,
               myData$CategThirdVar)
tab1
tab1_colProp <- prop.table(tab1, 2)
tab1_colProp

# __________________________________________________

# ==== categorical explanatory, quantitative response, categorical 3rd variable ====
ftable(by(myData$QuantResponseVar,
          list(myData$CategExplanatoryVar, 
               myData$CategThirdVar),
          mean, na.rm = TRUE))

# __________________________________________________

# ---- End ----