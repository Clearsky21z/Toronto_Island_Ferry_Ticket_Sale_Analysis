#### Preamble ####
# Purpose: Handle ferry ticket sales data to perform time series analysis and identify peak sales trends.
# Author: John Zhang
# Date: September 2024
# Contact: junhan.zhang@mail.utoronto.ca
# License: MIT
# Pre-requisites: Requires the validated dataset "validated_ferry_ticket_counts.csv" to be available in the "data/cleaned_data" folder.
# Any other information needed? None

#### Time Series Analysis - Trend Detection and Seasonality ####
#### Workspace setup ####
library(tidyverse)
library(lubridate)
library(knitr)

#### Load the validated dataset ####
validated_data <- read_csv("data/analysis_data/validated_ferry_ticket_counts.csv")

#### Extract year, month, and day of the week for trend analysis ####
validated_data <- validated_data %>%
  mutate(
    date = as_date(timestamp),
    year = year(date),
    month = month(date, label = TRUE),
    week = week(date),
    day_of_week = wday(date, label = TRUE),
    hour = hour(timestamp)
  )

#### Daily Sales Summarization ####
#### Filter for the year 2023 ####
validated_data_2023 <- validated_data %>%
  mutate(date = as_date(timestamp)) %>%
  filter(year(date) == 2023)

#### Summarize daily sales for 2023 ####
daily_sales_2023 <- validated_data_2023 %>%
  group_by(date) %>%
  summarize(total_sales = sum(total_sales))

#### Plot daily sales trend for 2023 with custom x-axis labels ####
ggplot(daily_sales_2023, aes(x = date, y = total_sales)) +
  geom_line(color = "blue") +
  labs(title = "Daily Ferry Ticket Sales in 2023", x = "Date", y = "Total Sales") +
  scale_x_date(
    breaks = as.Date(c("2023-01-01", "2023-04-01", "2023-07-01", "2023-10-01", "2023-12-31")),
    labels = c("Jan 2023", "Apr 2023", "Jul 2023", "Oct 2023", "Dec 2023")
  ) +
  theme_minimal()

#### Monthly Seasonality - Aggregating by month ####
monthly_sales <- validated_data %>%
  group_by(year, month) %>%
  summarise(total_sales = sum(total_sales))

ggplot(monthly_sales, aes(x = month, y = total_sales, group = year, color = factor(year))) +
  geom_line(size = 1) +
  theme_minimal() +
  labs(
    title = "Monthly Trends in Ferry Ticket Sales",
    x = "Month",
    y = "Total Sales"
  ) +
  scale_color_brewer(palette = "Set1", name = "Year")

#### Hourly Sales (Peak Time Identification) ####
# Summarize hourly sales
hourly_sales <- validated_data %>%
  group_by(hour) %>%
  summarize(total_sales = sum(total_sales))

# Plot hourly sales trend
ggplot(hourly_sales, aes(x = hour, y = total_sales)) +
  geom_line(color = "darkgreen") +
  labs(title = "Hourly Ferry Ticket Sales", x = "Hour of the Day", y = "Total Sales") +
  theme_minimal()

#### Day of Week Analysis ####
# Summarize sales by day of the week
weekly_sales <- validated_data %>%
  group_by(day_of_week) %>%
  summarize(total_sales = sum(total_sales))

# Plot sales by day of the week
ggplot(weekly_sales, aes(x = day_of_week, y = total_sales)) +
  geom_bar(stat = "identity", fill = "orange") +
  labs(title = "Ferry Ticket Sales by Day of the Week", x = "Day of the Week", y = "Total Sales") +
  theme_minimal()

#### Peak Day Analysis ####
# Summarize total sales for each day
daily_sales <- validated_data %>%
  group_by(year, date) %>%
  summarize(total_sales = sum(total_sales), .groups = "drop")

# Find the day with the most sales for each year
peak_days <- daily_sales %>%
  group_by(year) %>%
  filter(total_sales == max(total_sales)) %>%
  ungroup()

# Output the result as a knitr table
peak_days %>%
  arrange(year) %>%
  kable(
    col.names = c("Year", "Peak Day", "Total Sales"),
    caption = "Peak Day for Each Year Based on Total Sales"
  )

#### Find the Top 5 Timestamps with the Highest Total Sales ####
# Sort the data by total_sales in descending order and select the top 5 rows
top_5_timestamps <- validated_data %>%
  arrange(desc(total_sales)) %>%
  slice(1:5)

# Output the result as a knitr table
top_5_timestamps %>%
  select(timestamp, total_sales) %>%
  kable(
    col.names = c("Timestamp", "Total Sales"),
    caption = "Top 5 Timestamps with the Highest Total Sales"
  )
