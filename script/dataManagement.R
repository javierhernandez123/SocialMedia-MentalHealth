# __________________________________________________

# ---- DATA MANAGEMENT ----
# __________________________________________________

# ==== Debugging Information ====

# Check current working directory
cat("Current working directory:", getwd(), "\n")

# List files in current directory
cat("Files in current directory:\n")
print(list.files())

# Check if data directory exists in current location
if (dir.exists("data")) {
  cat("Data directory found in current location\n")
  data_file_path <- file.path("data", "digital_habits_vs_mental_health.csv")
} else if (dir.exists("../data")) {
  cat("Data directory found one level up\n")
  data_file_path <- file.path("..", "data", "digital_habits_vs_mental_health.csv")
} else {
  stop("Data directory not found. Please check your project structure.")
}

cat("Looking for data file at:", data_file_path, "\n")
cat("Data file exists:", file.exists(data_file_path), "\n")

if (!file.exists(data_file_path)) {
  stop("Data file not found. Please check the file path.")
}

# ==== Load Required Packages ====

# Check if required packages are installed, install if not
packages <- c("Hmisc", "dplyr", "readr")
for (pkg in packages) {
  if (!require(pkg, character.only = TRUE)) {
    cat("Installing package:", pkg, "\n")
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
}

# ==== Load Data ====

# Clear any existing df object
if (exists("df")) {
  rm(df)
  cat("Removed existing df object\n")
}

# Load the CSV file into a dataframe
cat("Loading data...\n")
df <- read_csv(data_file_path)

# Verify data loaded correctly
if (exists("df")) {
  cat("Data loaded successfully!\n")
  cat("Dataframe dimensions:", nrow(df), "rows,", ncol(df), "columns\n")
  cat("Column names:", paste(colnames(df), collapse = ", "), "\n")
  
  # Show first few rows
  cat("First 3 rows of data:\n")
  print(head(df, 3))
} else {
  stop("Failed to load data. df object not created.")
}

# ==== Basic Operations ====

# == equality
# >= greater than or equal
# <= less than or equal
# > greater than
# < less than
# != not equal to

# __________________________________________________

# ==== Identify missing data ==== 

# Check for missing values in the dataset
cat("\nChecking for missing values...\n")
missing_values <- sapply(df, function(x) sum(is.na(x)))
print("Missing values by variable:")
print(missing_values)

# __________________________________________________

# ==== Collapsing response categories ====

cat("\nCreating categorical variables...\n")

# Create a new variable for social media usage categories
df$social_media_category <- NA
df$social_media_category[df$social_media_platforms_used == 1 | df$social_media_platforms_used == 2] <- "Low"
df$social_media_category[df$social_media_platforms_used == 3] <- "Medium"
df$social_media_category[df$social_media_platforms_used == 4 | df$social_media_platforms_used == 5] <- "High"

# Create a new variable for screen time categories
df$screen_time_category <- NA
df$screen_time_category[df$screen_time_hours < 4] <- "Low"
df$screen_time_category[df$screen_time_hours >= 4 & df$screen_time_hours < 8] <- "Medium"
df$screen_time_category[df$screen_time_hours >= 8] <- "High"

# Create a new variable for sleep quality categories
df$sleep_quality <- NA
df$sleep_quality[df$sleep_hours < 6] <- "Poor"
df$sleep_quality[df$sleep_hours >= 6 & df$sleep_hours < 8] <- "Adequate"
df$sleep_quality[df$sleep_hours >= 8] <- "Good"

cat("Categorical variables created\n")

# __________________________________________________

# ==== Aggregating across variables ====

cat("\nCreating aggregated variables...\n")

# Create a digital intensity score combining screen time and social media usage
df$digital_intensity <- 0
df$digital_intensity[df$screen_time_hours > 6 & df$social_media_platforms_used > 3] <- 1

# Create a mental health indicator combining stress and mood
df$mental_health_indicator <- 0
df$mental_health_indicator[df$stress_level > 7 | df$mood_score < 6] <- 1

cat("Aggregated variables created\n")

# __________________________________________________

# ==== Create a quantitative variable ====

cat("\nCreating quantitative variables...\n")

# Create a composite digital habits score
df$digital_habits_score <- (df$screen_time_hours / 12) * 0.4 + 
  (df$social_media_platforms_used / 5) * 0.3 + 
  (df$hours_on_TikTok / 7.2) * 0.3

# Create a mental health score (inverse of stress + mood)
df$mental_health_score <- (10 - df$stress_level) + df$mood_score

cat("Quantitative variables created\n")

# __________________________________________________

# ==== Labeling variables ==== 

cat("\nLabeling variables...\n")

# for frequency tables
label(df$screen_time_hours) <- "Daily screen time in hours"
label(df$social_media_platforms_used) <- "Number of social media platforms used"
label(df$hours_on_TikTok) <- "Hours spent on TikTok daily"
label(df$sleep_hours) <- "Average hours of sleep per night"
label(df$stress_level) <- "Self-reported stress level (1-10)"
label(df$mood_score) <- "Self-reported mood score (1-10)"
label(df$social_media_category) <- "Social media usage category"
label(df$screen_time_category) <- "Screen time category"
label(df$sleep_quality) <- "Sleep quality category"
label(df$digital_intensity) <- "High digital intensity indicator"
label(df$mental_health_indicator) <- "Mental health concern indicator"
label(df$digital_habits_score) <- "Composite digital habits score"
label(df$mental_health_score) <- "Composite mental health score"

cat("Variables labeled\n")

# __________________________________________________

# ==== Labeling variable responses/values ==== 

cat("\nSetting factor levels...\n")

# Label social media categories
df$social_media_category <- factor(df$social_media_category, 
                                   levels = c("Low", "Medium", "High"))

# Label screen time categories
df$screen_time_category <- factor(df$screen_time_category, 
                                  levels = c("Low", "Medium", "High"))

# Label sleep quality categories
df$sleep_quality <- factor(df$sleep_quality, 
                           levels = c("Poor", "Adequate", "Good"))

cat("Factor levels set\n")

# __________________________________________________

# ==== Sample subset ==== 

cat("\nCreating subsets...\n")

# Create a subset of high digital intensity users
high_intensity_users <- df[df$digital_intensity == 1, ]
cat("High intensity users subset created:", nrow(high_intensity_users), "rows\n")

# Create a subset of users with mental health concerns
mental_health_concerns <- df[df$mental_health_indicator == 1, ]
cat("Mental health concerns subset created:", nrow(mental_health_concerns), "rows\n")

# Create a subset of users with high stress and low mood
high_stress_low_mood <- df[df$stress_level > 7 & df$mood_score < 6, ]
cat("High stress low mood subset created:", nrow(high_stress_low_mood), "rows\n")

# Create a subset of users with good sleep quality
good_sleepers <- df[df$sleep_quality == "Good", ]
cat("Good sleepers subset created:", nrow(good_sleepers), "rows\n")

# Create a subset of users with high digital habits score
high_digital_habits <- df[df$digital_habits_score > 0.6, ]
cat("High digital habits subset created:", nrow(high_digital_habits), "rows\n")

# __________________________________________________

# ==== Save the managed dataset ====

cat("\nSaving files...\n")

# Create data directory if it doesn't exist
if (!dir.exists("data")) {
  dir.create("data", recursive = TRUE)
  cat("Created data directory\n")
}

# Save the managed dataset for future analysis
write.csv(df, file = "data/digital_habits_managed.csv", row.names = FALSE)
cat("Saved managed dataset\n")

# Save subsets for specific analyses
write.csv(high_intensity_users, file = "data/high_intensity_users.csv", row.names = FALSE)
write.csv(mental_health_concerns, file = "data/mental_health_concerns.csv", row.names = FALSE)
write.csv(high_stress_low_mood, file = "data/high_stress_low_mood.csv", row.names = FALSE)
write.csv(good_sleepers, file = "data/good_sleepers.csv", row.names = FALSE)
write.csv(high_digital_habits, file = "data/high_digital_habits.csv", row.names = FALSE)
cat("All subsets saved\n")

# Print summary of data management process
cat("\n=== DATA MANAGEMENT SUMMARY ===\n")
cat("Original dataset dimensions:", nrow(df), "rows,", ncol(df), "columns\n")
cat("High digital intensity users:", nrow(high_intensity_users), "rows\n")
cat("Users with mental health concerns:", nrow(mental_health_concerns), "rows\n")
cat("Users with high stress and low mood:", nrow(high_stress_low_mood), "rows\n")
cat("Users with good sleep quality:", nrow(good_sleepers), "rows\n")
cat("Users with high digital habits score:", nrow(high_digital_habits), "rows\n")
cat("Data management completed successfully!\n")

# __________________________________________________

# ---- End ----