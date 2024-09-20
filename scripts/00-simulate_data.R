#### Preamble ####
# Purpose: Simulates ferry ticket redemption and sales data with timestamp intervals
# Author: John Zhang
# Date: September 2024
# Contact: junhan.zhang@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(lubridate)

#### Simulate data ####
# Set a seed for reproducibility
set.seed(21)

# Parameters for simulation
n <- 1000  # Number of records to simulate
start_time <- as.POSIXct("2024-01-01 00:00:00")  # Start time for simulation
end_time <- as.POSIXct("2024-01-31 23:59:59")  # End time for simulation

# Create a sequence of timestamps for 15-minute intervals
timestamps <- seq(from = start_time, to = end_time, by = "15 mins")

# Sample the redemption and sales count from a Poisson distribution (since counts are natural numbers)
redemption_count <- rpois(n, lambda = 50)  # Average of 50 redemptions per 15 minutes
sales_count <- rpois(n, lambda = 60)  # Average of 60 sales per 15 minutes

# ID column
ID <- 1:n

# Simulated dataset
simulated_data <- tibble(
  ID = ID,
  timestamp = sample(timestamps, n, replace = TRUE),  # Sample random timestamps
  Redemption_Count = redemption_count,
  Sales_Count = sales_count
)

# View simulated data
print(head(simulated_data))

#### Basic tests ####
# Ensure that Redemption_Count and Sales_Count are non-negative integers
test_redemption_positive <- all(simulated_data$Redemption_Count >= 0)
test_sales_positive <- all(simulated_data$Sales_Count >= 0)

# Ensure timestamps are within the correct range
test_timestamps_range <- all(simulated_data$timestamp >= start_time & simulated_data$timestamp <= end_time)

# Print test results
print(paste("All redemption counts non-negative:", test_redemption_positive))
print(paste("All sales counts non-negative:", test_sales_positive))
print(paste("All timestamps within range:", test_timestamps_range))

# Save simulated data to CSV for later use
write_csv(simulated_data, "data/simulated_ferry_ticket_sales.csv")
