# CTRL shift A, ordner dine koder

# load up the packages
source(here::here("R/package-loading.R"))

#briefly glimpse content of dataset
glimpse(NHANES)

#select one column by its name
select(NHANES, Age)

# select more columns
select(NHANES, Age, Weight, BMI)

# Exclude a column
select(NHANES, -HeadCirc)

# all columns starting with "BP"
select(NHANES, starts_with("BP"))

# columns ending with "day"
select(NHANES, ends_with("Day"))

# columns containing AGE
select(NHANES, contains("Age"))

?select_helpers


# save the selected columns as a new data frame


nhanes_small <- select(NHANES, Age, Gender, Height,
                       Weight, BMI, Diabetes, DiabetesAge,
                       PhysActiveDays, PhysActive, TotChol,
                       BPSysAve, BPDiaAve, SmokeNow, Poverty)

# View the new data frame

nhanes_small


## Renaming
# REname all columns to snake case

nhanes_small <- rename_with(nhanes_small, snakecase::to_snake_case)

nhanes_small

# renaming specific columns
rename(nhanes_small, sex = gender)

nhanes_small

# skal dog gemmes;
nhanes_small <- rename(nhanes_small, sex = gender)


## The pipe operator

# without the pipe operator
colnames(nhanes_small)

# with pipe operator (Ctrl + shift + M)
nhanes_small %>% colnames()

# using the pipe perator with more functions

nhanes_small %>%
    select(phys_active) %>%
    rename(physically_active = phys_active)
