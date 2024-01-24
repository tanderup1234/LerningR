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

# Filtering data by row ---------------------------------------------------

#With filter to keep individuals with No use ==
NHANES_small %>%
    filter(phys_active == 'No')


#With filter to remove individuals with No use !=

# Participants who are physically active
NHANES_small %>%
    filter(phys_active != "No")

#Try with bmi
#Keeping only Participants who have BMI equal to 25
NHANES_small %>%
    filter(bmi == 25)

# Participants who have BMI equal to or more than 25
NHANES_small %>%
    filter(bmi >= 25)

#We want to use and/or in filter()

TRUE & TRUE
TRUE & FALSE
FALSE & FALSE

TRUE | TRUE
TRUE | FALSE
FALSE | FALSE

#Here R only includes individuals with bmi of 25 and phys_active = No
NHANES_small %>%
    select(bmi, phys_active) %>%
    filter(bmi == 25 & phys_active == 'No')

#Here R includes both thos with bmi of 25 and physically active == NO
NHANES_small %>%
    select(bmi, phys_active) %>%
    filter(bmi == 25 | phys_active == 'No')



# Arranging the rows ------------------------------------------------------

#This codes arranges the variables by age
NHANES_small %>%
    arrange(age)

NHANES_small %>%
    select(education) %>%
    arrange(education)

NHANES_small %>%
    select(age) %>%
    arrange(desc(age))


NHANES_small %>%
    select(age, education) %>%
    arrange(age, education)

# Transform or add columns ------------------------------------------------

NHANES_small %>%
    mutate(age = age * 12)

NHANES_small %>%
    mutate(age = age * 12,
           logged_bmi = log(bmi)) %>%
    select(age, logged_bmi)

NHANES_small %>%
    mutate(old = if_else(age >= 30, "Yes", "No")) %>%
    select(old)

# Exercise 7.12 -----------------------------------------------------------

# 1. BMI between 20 and 40 with diabetes
NHANES_small %>%
    # Format should follow: variable >= number or character
    filter(bmi >= 20 & bmi <= 40 & diabetes == 'Yes') %>%
    select(bmi)

# Pipe the data into mutate function and:
nhanes_modified <- NHANES_small %>% # Specifying dataset
    mutate(
        # 2. Calculate mean arterial pressure
        mean_arterial_bp = ((2*bp_dia_ave)+bp_sys_ave)/3,
        # 3. Create young_child variable using a condition
        young_child = if_else(age <= 6, "Yes", "No")
    )

nhanes_modified



