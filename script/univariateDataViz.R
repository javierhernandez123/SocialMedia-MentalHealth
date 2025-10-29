# __________________________________________________

# ---- UNIVARIATE GRAPHS ---- 
# __________________________________________________

# Load the library
library(ggplot2)
library(dplyr)

# First, let's load the managed data if not already in the environment
if (!exists("df")) {
  data_file_path <- file.path("data", "digital_habits_managed.csv")
  if (file.exists(data_file_path)) {
    df <- read.csv(data_file_path)
    cat("Loaded managed data from file\n")
  } else {
    # If managed data doesn't exist, load original data and apply transformations
    data_file_path <- file.path("data", "digital_habits_vs_mental_health.csv")
    df <- read.csv(data_file_path)
    
    # Apply the same transformations from dataManagement.R
    df$screen_time_category[df$screen_time_hours < 4] <- "Low"
    df$screen_time_category[df$screen_time_hours >= 4 & df$screen_time_hours < 8] <- "Medium"
    df$screen_time_category[df$screen_time_hours >= 8] <- "High"
    df$screen_time_category <- factor(df$screen_time_category, levels = c("Low", "Medium", "High"))
    
    cat("Loaded original data and applied transformations\n")
  }
}

# ==== Categorical Variable: Screen Time Category ====

# Create a bar plot for screen time category
screen_time_plot <- df %>%
  ggplot(aes(x = screen_time_category)) +
  geom_bar(fill = "skyblue", color = "black") + 
  ggtitle("Distribution of Screen Time Categories") +
  xlab("Screen Time Category") +
  ylab("Count") +
  theme_minimal()

# Display the plot
print(screen_time_plot)

# Get frequency counts for screen time category
screen_time_freq <- df %>%
  count(screen_time_category) %>%
  mutate(percent = round(100 * n / sum(n), 1))

print(screen_time_freq)

# ==== Quantitative Variable: Stress Level ====

# Create a histogram for stress level
stress_level_plot <- df %>%
  ggplot(aes(x = stress_level)) +
  geom_histogram(binwidth = 0.5, fill = "lightblue", color = "black") +  
  ggtitle("Distribution of Stress Level") +
  xlab("Stress Level (1-10)") +
  ylab("Frequency") +
  theme_minimal()

# Display the plot
print(stress_level_plot)

# Get summary statistics for stress level
stress_level_summary <- summary(df$stress_level)
print(stress_level_summary)

# Calculate additional statistics
mean_stress <- mean(df$stress_level, na.rm = TRUE)
median_stress <- median(df$stress_level, na.rm = TRUE)
sd_stress <- sd(df$stress_level, na.rm = TRUE)
min_stress <- min(df$stress_level, na.rm = TRUE)
max_stress <- max(df$stress_level, na.rm = TRUE)

cat("\nStress Level Statistics:\n")
cat("Mean:", round(mean_stress, 3), "\n")
cat("Median:", round(median_stress, 3), "\n")
cat("Standard Deviation:", round(sd_stress, 3), "\n")
cat("Range:", round(min_stress, 3), "to", round(max_stress, 3), "\n")

# __________________________________________________

# ---- ANALYSIS OF GRAPHS ----
# __________________________________________________

cat("\n=== ANALYSIS OF SCREEN TIME CATEGORY GRAPH ===\n")
cat("The bar chart shows the distribution of screen time categories.\n")
cat("The most common category (modal frequency) is", 
    screen_time_freq$screen_time_category[which.max(screen_time_freq$n)], 
    "with", screen_time_freq$n[which.max(screen_time_freq$n)], 
    "observations (", screen_time_freq$percent[which.max(screen_time_freq$n)], "%).\n")
cat("The least common category is", 
    screen_time_freq$screen_time_category[which.min(screen_time_freq$n)], 
    "with", screen_time_freq$n[which.min(screen_time_freq$n)], 
    "observations (", screen_time_freq$percent[which.min(screen_time_freq$n)], "%).\n")

cat("\n=== ANALYSIS OF STRESS LEVEL GRAPH ===\n")
cat("The histogram shows the distribution of stress levels.\n")
cat("The distribution appears to be", 
    ifelse(mean_stress > median_stress, "right-skewed", "left-skewed"), 
    "with a mean of", round(mean_stress, 3), "and a median of", round(median_stress, 3), ".\n")
cat("The stress levels range from", round(min_stress, 3), "to", round(max_stress, 3), 
    "with a standard deviation of", round(sd_stress, 3), ".\n")

# Check for outliers using the 1.5*IQR rule
q1 <- quantile(df$stress_level, 0.25, na.rm = TRUE)
q3 <- quantile(df$stress_level, 0.75, na.rm = TRUE)
iqr <- q3 - q1
lower_bound <- q1 - 1.5 * iqr
upper_bound <- q3 + 1.5 * iqr

outliers <- df$stress_level[df$stress_level < lower_bound | df$stress_level > upper_bound]
cat("There are", length(outliers), "potential outliers in the stress level distribution.\n")

# Since stress level is an ordered variable, we can also comment on the modal frequency
modal_stress <- as.numeric(names(sort(table(df$stress_level), decreasing = TRUE)[1]))
cat("The modal stress level is", modal_stress, "with", 
    sum(df$stress_level == modal_stress), "observations.\n")

# __________________________________________________

# ---- End ----