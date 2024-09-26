#### Preamble ####
# Purpose: Cleans the raw ferry ticket data and prepares it for analysis by standardizing the columns, filtering for relevant date range, and adding a total sales column.
# Author: John Zhang
# Date: September 2024
# Contact: junhan.zhang@mail.utoronto.ca
# License: MIT
# Pre-requisites: The raw dataset "unedited_ferry_ticket_counts.csv" should be available in the "data/raw_data" folder.
# Any other information needed? None


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
  mutate(total_sales = redemption_count + sales_count) |> # Create new column for total sales
  mutate(x_id = row_number()) |>  # Ensure x_id starts from 1 and is continuous
  drop_na()  # Drop rows with missing values

#### Save cleaned data ####
write_csv(cleaned_data, "data/analysis_data/cleaned_ferry_ticket_counts.csv")

# Print message to confirm cleaning process
print("Data successfully cleaned and saved as 'cleaned_ferry_ticket_counts.csv'")