#### Preamble ####
# Purpose: Downloads and saves the data from the Toronto Island Ferry Ticket Counts dataset
# Author: John Zhang
# Date: September 2024
# Contact: junhan.zhang@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)

#### Download data ####
# Get package information for Toronto Island Ferry Ticket Counts
package <- show_package("toronto-island-ferry-ticket-counts")

# Get all resources for this package
resources <- list_package_resources("toronto-island-ferry-ticket-counts")

# Identify datastore resources; by default, Open Data Toronto sets datastore resources to CSV or GeoJSON
datastore_resources <- filter(resources, tolower(format) %in% c("csv", "geojson"))

# Load the first datastore resource (CSV format)
the_raw_data <- filter(datastore_resources, row_number() == 2) %>% get_resource()

#### Save data ####
# Save the downloaded data to the raw_data folder
write_csv(the_raw_data, "data/raw_data/unedited_ferry_ticket_counts.csv")

# Print message to confirm successful download and saving
print("Data successfully downloaded and saved as 'unedited_ferry_ticket_counts.csv'")
