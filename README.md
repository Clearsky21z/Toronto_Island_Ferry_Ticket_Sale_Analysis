# Toronto Island Ferry Ticket Sales Analysis

## Overview

This repository contains the files and scripts used to analyze temporal patterns and passenger flow in Toronto Island ferry ticket sales. The analysis focuses on time series patterns, including daily, weekly, and monthly trends, seasonality, peak sales times, and day-of-week analysis. The goal is to provide insights into ferry operations and visitor patterns that can help optimize ferry services, especially during peak periods.

## File Structure

The repository is structured as:

- `data/raw_data`: Contains the raw data obtained from Open Data Toronto, covering ferry ticket sales and redemptions at 15-minute intervals.
- `data/analysis_data`: Contains the cleaned and validated dataset used for the analysis, focusing on complete yearly data from 2016 to 2023.
- `other`: Contains supporting material, such as literature references, notes on LLM chat interactions, and sketches.
- `paper`: Contains the Quarto document, the reference bibliography file, and the final PDF of the paper. This folder holds the paper that was generated based on the analysis.
- `scripts`: Contains R scripts used for data simulation, downloading from Open Data Toronto, cleaning, and performing the analysis.

## Statement on LLM usage

The abstract, introduction, and some sections were written with assistance from ChatGPT. The full chat history of interactions is available in the `other/llms/usage.txt` file.

## Some checks

- [ ] Change the R project file name so that it's not named "starter_folder.Rproj."
- [ ] Update the README title and other sections to reflect the project’s specific details.
- [ ] Remove unnecessary files that are not in use.
- [ ] Add and update comments in R scripts for clarity.
- [ ] Ensure the final README and file structure are well-documented.
