# __________________________________________________

# ---- UNIVARIATE GRAPHS ---- 
# __________________________________________________

# Load the library
library(ggplot2)

# ==== Categorical variable ====

ggplot(myData, aes(x = CategVar)) + geom_bar()

# elaborate
ggplot(data = myData, aes(x = CategVar)) +  
  geom_bar(fill = "skyblue", color = "black") + 
  ggtitle("Descriptive Title Here") +
  xlab("Category") +
  ylab("Count") +
  theme_minimal()

# with pipe
myData %>%
  ggplot(aes(x = CategVar)) +
  geom_bar(fill = "skyblue", color = "black") + 
  ggtitle("Descriptive Title Here") +
  xlab("Category") +
  ylab("Count") +
  theme_minimal() 

# __________________________________________________

# ==== Quantitative variable ====

ggplot(myData, aes(x = QuantVar)) + geom_histogram()

# elaborate
ggplot(data = myData, aes(x = QuantVar)) + 
  geom_histogram(binwidth = 5, fill = "lightblue", color = "black") +  
  ggtitle("Descriptive Title Here") +
  xlab("Value") +
  ylab("Frequency") +
  theme_minimal()

# with pipe
myData %>%
  ggplot(aes(x = QuantVar)) +
  geom_histogram(binwidth = 5, fill = "lightblue", color = "black") +  # Adds binwidth for better visualization
  ggtitle("Descriptive Title Here") +
  xlab("Value") +
  ylab("Frequency") +
  theme_minimal()

# __________________________________________________

# ---- End ----