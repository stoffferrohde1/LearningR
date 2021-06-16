# Load the packages
source(here::here("R/package-loading.R"))

# Check column names
colnames(NHANES)

# Look at contents
str(NHANES)
glimpse(NHANES)

# See summary
summary(NHANES)

# Look over the dataset documentation
?NHANES

# 9.9

nhanes_small %>%
    select(tot_chol, bp_sys_ave, poverty)

nhanes_small %>%
    rename(diabetes_diagnosis_age = diabetes_age)

nhanes_small %>%
    select(bmi, contains("age"))

nhanes_small %>%
    select(phys_active_days, phys_active) %>%
    rename(days_phys_active = phys_active_days)




################9.16

# 1.
nhanes_small %>%
    summarise(mean_weight = mean(weight, na.rm = TRUE),
              mean_age = mean(age))

# 2.
nhanes_small %>%
    summarise(max_height = max(height, na.rm = TRUE),
              min_height = min(height, na.rm = TRUE))

# 3.
nhanes_small %>%
    summarise(median_age = median(age),
                 median_phys_active_days = median(phys_active_days, na.rm = TRUE))
