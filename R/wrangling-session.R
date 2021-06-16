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



## filtering 9.10
# filter for all females/males

nhanes_small %>%
    filter(sex == "female")

nhanes_small %>%
    filter(sex != "female")

# BMI
nhanes_small %>%
    filter(bmi == 25)

# BMI>25
nhanes_small %>%
    filter(bmi >= 25)

# two variables, bmi and sex, and (&) or (|)

nhanes_small %>%
    filter(sex == "female" & bmi >= 25)

nhanes_small %>%
    filter(sex == "female" | bmi >= 25)


## Arranging you dataset

# arrange by age

nhanes_small %>%
    arrange(age)

# arrange by sex in ascending order
nhanes_small %>%
    arrange(sex)

# arranging by age in descending order

nhanes_small %>%
    arrange(desc(age))

# arranging by more variables (sex and age)

nhanes_small %>%
    arrange(sex, age)

## transform or add columns

# meters
nhanes_small %>%
    mutate(height = height / 100)

# log of the height in new column

nhanes_small %>%
    mutate(logged_height = log(height))

# add more columns

nhanes_small %>%
    mutate(height = height / 100, logged_height = log(height))

# add new column with conditions

nhanes_small %>%
    mutate(highly_active = if_else(phys_active_days >= 5,
                                   "Yes", "No"))

## gammer alt

nhanes_update <- nhanes_small %>%
    mutate(height = height / 100,
           logged_height = log(height),
           highly_active = if_else(phys_active_days >= 5, "Yes", "No"))

str(nhanes_update)

## summary statistics by group

nhanes_small %>%
    summarise(max_bmi = max(bmi))

nhanes_small %>%
    summarize(max_bmi = max(bmi, na.rm = TRUE))

nhanes_small %>%
    summarise(max_bmi = max(bmi, na.rm = TRUE),
              min_bmi = min(bmi, na.rm = TRUE))




## calulate summary stastictis by group

nhanes_small %>%
    group_by(diabetes) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE))


nhanes_small %>%
    filter(!is.na(diabetes)) %>%
    group_by(diabetes) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE)) %>%
    ungroup()


## saving datasets as files

# saving data as an .rda file in the data folder
usethis::use_data(nhanes_small, overwrite = TRUE)



