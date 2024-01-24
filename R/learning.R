# Loading packages --------------------------------------------------------

library(tidyverse)
library(NHANES)

# Briefly glimpse contents of dataset
glimpse(NHANES)

str(NHANES)
head(NHANES)



# Select specific columns -------------------------------------------------

# Select one column by its name, without quotes
select(NHANES, Age)



# Select two or more columns by name, without quotes
select(NHANES, Age, Weight, BMI)
select(NHANES, -HeadCirc)


# All columns starting with letters "BP" (blood pressure)
select(NHANES, starts_with("BP"))


# All columns ending in letters "Day"
select(NHANES, ends_with("Day"))


# All columns containing letters "Age"
select(NHANES, contains("Age"))



# Renaming all columns --------------------------------------------------------

# This will make all the columns in the dataset into snake_case style
NHANES_small <- rename_with(NHANES, snakecase::to_snake_case)

NHANES_small

# Renaming specific column ------------------------------------------------
NHANES_small <- rename(NHANES_small, sex = gender)

NHANES_small
view(NHANES_small)

# Changing the function with the pipe -------------------------------------

colnames(NHANES_small)

NHANES_small %>%
  colnames()

# Piping with select() and rename()
NHANES_phys <- NHANES_small %>%
  select(phys_active) %>%
  rename(physically_active = phys_active)

# Exercise 7.8 in material ------------------------------------------------

# Selecting
NHANES_small %>%
  select(bp_sys_ave, education)

# Renaming
NHANES_small %>%
  rename(
    bp_sys = bp_sys_ave,
    bp_dia = bp_dia_ave
  )

NHANES_small %>%
  select(bmi, contains("age"))

# Avoiding making the extra blood pressure object
# first code
blood_pressure <- select(nhanes_small, starts_with("bp_"))
rename(blood_pressure, bp_systolic = bp_sys_ave)

# New code with pipe
NHANES_small %>%
  select(starts_with("bp_")) %>%
  rename(bp_systolic = bp_sys_ave)
