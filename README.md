# SocialMedia-MentalHealth

Dataset keyword: **digital-habits**

This repository contains the Quarto analysis for the open-source **"Impact of Digital Habits on Mental Health"** dataset (N = 100,000). All variables are synthetically generated and ethically mined (no PII).

## Project Overview

This project explores the relationship between digital habits and mental health indicators among young adults. The analysis follows best practices for data organization, loading, and exploration in R using Quarto.

## Research Questions & Hypotheses

### Primary Research Question
Is there a relationship between digital habits (screen time and social media usage) and mental health indicators (stress levels and mood scores) among young adults?

### Secondary Research Questions
- How does screen time relate to stress levels?
- What is the distribution of mood scores in the population?
- Are there patterns in social media platform usage that relate to mental health outcomes?

### Primary Hypothesis
- **H₀:** There is no relationship between screen time hours and stress level among young adults.
- **Hₐ:** There is a relationship between screen time hours and stress level among young adults.

### Additional Hypotheses
1. **H₀:** There is no difference in mood scores across different levels of social media platform usage.
   **Hₐ:** There is a difference in mood scores across different levels of social media platform usage.
   *Statistical Test:* ANOVA

2. **H₀:** There is no association between sleep hours and mood scores.
   **Hₐ:** There is an association between sleep hours and mood scores.
   *Statistical Test:* Correlation test (Pearson's r)

## Dataset

The dataset `digital_habits_vs_mental_health.csv` contains 100,000 observations with the following variables:

| Variable | Type | Range | Mean | Description |
|----------|------|-------|------|-------------|
| screen_time_hours | Quantitative | 1-12 hours | 6.0 hours | Total hours of screen time per day |
| social_media_platforms_used | Quantitative | 1-5 platforms | 3.0 platforms | Number of social media platforms used |
| hours_on_TikTok | Quantitative | 0.2-7.2 hours | 2.4 hours | Hours spent specifically on TikTok |
| sleep_hours | Quantitative | 3-10 hours | 7.0 hours | Average hours of sleep per night |
| stress_level | Quantitative | 1-10 scale | 6.18 | Self-reported stress level (1-10 scale) |
| mood_score | Quantitative | 2-10 scale | 9.06 | Self-reported mood score (1-10 scale) |

## Key Findings

### Distribution Patterns
- **Stress Level:** Approximately normal distribution with peak at level 6 (18.5% of respondents)
- **Mood Score:** Notably skewed toward higher values with 54% reporting maximum score of 10
- **Social Media Usage:** Evenly distributed across 1-5 platforms (approximately 20% each)
- **Screen Time:** Approximately normal distribution with slight right skewness
- **Sleep Hours:** Mean of 7.0 hours, aligning with recommended adult sleep duration

### Preliminary Relationships
- Potential inverse relationship between screen time (mean 6.0 hours) and sleep (mean 7.0 hours)
- High mood scores combined with moderate stress levels suggest complex relationships
- Even distribution of social media usage suggests no preference for particular number of platforms

## Folder Structure
SocialMedia-MentalHealth/
├── data/
│   ├── digital_habits_vs_mental_health.csv
│   ├── digital_habits_managed.csv
│   ├── high_intensity_users.csv
│   ├── mental_health_concerns.csv
│   └── [other subset files]
├── plots/
│   ├── [univariate plots]
│   ├── [bivariate plots]
│   └── [other visualization files]
├── script/
│   ├── workingWithData.qmd
│   ├── dataManagement.R
│   ├── univariateGraphs.R
│   ├── bivariateGraphs.R
│   └── [other analysis scripts]
└── README.md

How to Reproduce
Prerequisites

R (version 4.0 or higher)

RStudio IDE

Required R packages:

tidyverse

questionr

Hmisc

ggplot2

Installation

Clone the repository:

git clone https://github.com/javierhernandez123/SocialMedia-MentalHealth.git


Navigate to the project directory:

cd SocialMedia-MentalHealth


Install required R packages:

install.packages(c("tidyverse", "questionr", "Hmisc", "ggplot2"))

Running the Analysis

Open the project in RStudio

Run the data management script:

source("script/dataManagement.R")


Run the univariate analysis:

source("script/univariateGraphs.R")


Run the bivariate analysis:

source("script/bivariateGraphs.R")


View the Quarto report:

script/workingWithData.qmd

Analysis Steps

The analysis follows these key stages:

1. Data Loading

Define file path

Load CSV data into a dataframe

Preview the data

2. Data Management

Create categorical variables (social_media_category, screen_time_category, sleep_quality)

Create composite variables (digital_intensity, mental_health_indicator, digital_habits_score)

Label variables and create subsets for analysis

3. Univariate Analysis

Create frequency tables for key variables

Generate univariate graphs for categorical and quantitative variables

Analyze distributions and identify patterns

4. Bivariate Analysis

Explore relationships between digital habits and mental health indicators

Create various bivariate visualizations

Analyze third-variable effects

5. Hypothesis Testing

Test primary hypothesis: screen time vs. stress level

Test secondary hypotheses: mood scores vs. social media usage

Apply appropriate statistical tests (correlation, ANOVA)

Statistical Tests Applied
Variable Pair	Test	Rationale
screen_time_hours & stress_level	Pearson's r	Both quantitative variables
social_media_platforms_used & mood_score	ANOVA	Categorical–quantitative relationship
sleep_hours & mood_score	Pearson's r	Both quantitative variables
Future Directions

Investigate Mood Score Ceiling Effect: The high percentage of maximum scores warrants further investigation

Examine Subgroup Differences: Analyze whether relationships differ by demographic factors

Explore Non-linear Relationships: Investigate potential non-linear patterns between variables

Longitudinal Analysis: Consider how these relationships might change over time

Author

Javier Hernandez – Initial work
GitHub: @javierhernandez123
