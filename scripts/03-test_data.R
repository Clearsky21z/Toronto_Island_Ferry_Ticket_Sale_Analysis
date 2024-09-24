#### Preamble ####
# Purpose: Tests the cleaned ferry ticket data for quality and consistency
# Author: John Zhang
# Date: September 2024
# Contact: junhan.zhang@mail.utoronto.ca
# License: MIT
# Pre-requisites: The cleaned dataset "cleaned_ferry_ticket_counts.csv" should be available
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
library(lubridate)

#### Load cleaned data ####
cleaned_data <- read_csv("data/analysis_data/cleaned_ferry_ticket_counts.csv")

#### Test data ####

# Test 1: Ensure that "redemption_count" and "sales_count" are non-negative integers
test_redemption_positive <- all(cleaned_data$redemption_count >= 0)
test_sales_positive <- all(cleaned_data$sales_count >= 0)

# Test 2: Ensure timestamps are in a valid range (e.g., between 2016 and 2023)
start_time <- as_datetime("2016-01-01 00:00:00")
end_time <- as_datetime("2023-12-31 23:59:59")
test_timestamps_range <- all(cleaned_data$timestamp >= start_time & cleaned_data$timestamp <= end_time)

# Test 3: Ensure "total_sales" is logical (i.e., no negative values)
test_total_sales_positive <- all(cleaned_data$total_sales >= 0)

# Test 4: Check for duplicates in the dataset (should not have duplicate rows for same timestamp)
test_no_duplicates <- nrow(cleaned_data) == nrow(distinct(cleaned_data, timestamp))

# Test 5: Check for missing values in the key columns
test_no_missing_values <- all(complete.cases(cleaned_data$timestamp, cleaned_data$redemption_count, cleaned_data$sales_count))

#### Print test results ####
print(paste("All redemption counts non-negative:", test_redemption_positive))
print(paste("All sales counts non-negative:", test_sales_positive))
print(paste("All timestamps within range:", test_timestamps_range))
print(paste("All total sales non-negative:", test_total_sales_positive))
print(paste("No duplicate timestamps:", test_no_duplicates))
print(paste("No missing values in key columns:", test_no_missing_values))

# Conditional test output: Print message if any test fails
if (!test_redemption_positive) {
  warning("Some redemption counts are negative!")
}
if (!test_sales_positive) {
  warning("Some sales counts are negative!")
}
if (!test_timestamps_range) {
  warning("Some timestamps are out of the expected range!")
}
if (!test_total_sales_positive) {
  warning("Some total sales values are negative!")
}
if (!test_no_duplicates) {
  warning("There are duplicate timestamps in the data!")
}
if (!test_no_missing_values) {
  warning("There are missing values in key columns!")
}

# Optional: Save the cleaned dataset if it passes all tests
if (all(test_redemption_positive, test_sales_positive, test_timestamps_range, test_total_sales_positive, test_no_duplicates, test_no_missing_values)) {
  write_csv(cleaned_data, "data/analysis_data/validated_ferry_ticket_counts.csv")
  print("Data passed all tests and saved as 'validated_ferry_ticket_counts.csv'")
} else {
  warning("Data did not pass all tests. Check issues and fix them before proceeding.")
}
