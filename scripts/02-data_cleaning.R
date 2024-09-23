#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(lubridate)

#### Clean data ####
# Load the raw data
raw_data <- read_csv("data/raw_data/unedited_ferry_ticket_counts.csv")

# Clean the dataset
cleaned_data <- raw_data |>
  janitor::clean_names() |>  # Clean column names
  select(x_id, timestamp, redemption_count, sales_count) |>  # Select relevant columns based on correct names
  mutate(timestamp = as_datetime(timestamp)) |>  # Convert timestamp to datetime format
  filter(year(timestamp) >= 2016 & year(timestamp) <= 2023) |>  # Filter rows between 2016-2023
  mutate(total_sales = redemption_count + sales_count) |>  # Create new column for total sales
  drop_na()  # Drop rows with missing values

#### Save cleaned data ####
write_csv(cleaned_data, "data/analysis_data/cleaned_ferry_ticket_counts.csv")

# Print message to confirm cleaning process
print("Data successfully cleaned and saved as 'cleaned_ferry_ticket_counts.csv'")