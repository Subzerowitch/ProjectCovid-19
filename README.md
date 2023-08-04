# ProjectCovid-19
 
 Research project on Covid-19. Source of the dataset: https://ourworldindata.org/covid-deaths
 
 Visualization https://public.tableau.com/app/profile/olena.rubanenko/viz/Covid-19_16878630219010/Dashboard1

## Project Title: COVID-19 Data Analysis using SQL

## Project Overview:

This SQL project aims to analyze COVID-19 data, specifically focusing on infection rates, death rates, and vaccination statistics across different countries and continents. The dataset used for this analysis contains information on COVID-19 cases, deaths, and vaccinations from various locations worldwide.

## Dataset Source:

The dataset used for this project is stored in a SQL Server database named "ProjectCovid-19." It consists of two main tables:

-covid_deaths: Contains information on COVID-19 cases, deaths, and population data.
-covid_vaccinations: Contains data related to COVID-19 vaccinations.

## Project Objectives:

Analyze COVID-19 deaths by continent and location to identify patterns and trends.

Calculate the death percentage for specific countries (e.g., Ukraine) to understand the mortality rate.

Calculate the percentage of the population infected in specific countries to assess the infection rate.

Identify countries with the highest infection rate compared to their population.

Identify countries with the highest death count per population to determine the impact of COVID-19 on different regions.

Analyze vaccination statistics to understand the progress of vaccination efforts.

Create a view to store vaccination statistics for further visualizations and analysis.

## SQL Queries:

The project uses a series of SQL queries to retrieve, calculate, and analyze the data. Some of the key queries used include:

-Retrieving data from the covid_deaths table, filtering by continent or specific country.

-Calculating death percentages and infection rates based on the total_cases and total_deaths columns.

-Using aggregate functions and grouping to find countries and continents with the highest death count or infection rates.

-Joining the covid_deaths and covid_vaccinations tables to analyze vaccination statistics.

-Creating temporary tables and views to store intermediate results and facilitate further analysis.

