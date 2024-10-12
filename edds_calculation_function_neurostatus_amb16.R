# R Script for calculation of the total EDSS based on scores from functional subsystems
# Author: Jiri Motyl, Ph.D. (jiri.motyl@vfn.cz), October2024

## Calculations based on the Neurostatus adaptation of the scoring system (Kappos et al.): https://www.neurostatus.net/scoring/index.php (with 16 Ambulation subscores)
## Acknowledgments: Aleksandar Dobrašinovic (https://github.com/adobrasinovic/edss) for inspiration and clear overview of the conditions. ChatGPT for final corrections and review of the proposed script.


# EDSS calculation script

edss_calculation <- function(score_pyramidal, score_cerebellar, score_brain_stem, score_sensory,
                             score_bowel_bladder, score_visual, score_mental, score_ambulation) {
  
  ## Create visual converted FS score
  if (score_visual == 0) {
    score_visual_converted <- 0
  } else if (score_visual == 1) {
    score_visual_converted <- 1
  } else if (score_visual == 2 || score_visual == 3) {
    score_visual_converted <- 2
  } else if (score_visual == 4 || score_visual == 5) {
    score_visual_converted <- 3
  } else if (score_visual == 6) {
    score_visual_converted <- 4
  } else {
    score_visual_converted <- NA
  }
  
  ## Create bowel-bladder converted FS score
  if (score_bowel_bladder == 0) {
    score_bowel_bladder_converted <- 0
  } else if (score_bowel_bladder == 1) {
    score_bowel_bladder_converted <- 1
  } else if (score_bowel_bladder == 2) {
    score_bowel_bladder_converted <- 2
  } else if (score_bowel_bladder == 3 || score_bowel_bladder == 4) {
    score_bowel_bladder_converted <- 3
  } else if (score_bowel_bladder == 5) {
    score_bowel_bladder_converted <- 4
  } else if (score_bowel_bladder == 6) {
    score_bowel_bladder_converted <- 5
  } else {
    score_bowel_bladder_converted <- NA
  }
  
  ## FS Mental - transform 1 to 0 for EDSS calculation purposes
  if (score_mental == 0 || score_mental == 1) {
    score_mental_converted <- 0
  } else if (score_mental == 2) {
    score_mental_converted <- 2
  } else if (score_mental == 3) {
    score_mental_converted <- 3
  } else if (score_mental == 4) {
    score_mental_converted <- 4
  } else if (score_mental == 5) {
    score_mental_converted <- 5
  } else {
    score_mental_converted <- NA
  }
  
  subsystems <- c(score_pyramidal, score_cerebellar, score_brain_stem, score_sensory,
                  score_bowel_bladder_converted, score_visual_converted, score_mental_converted)
  
  ## Count the number of FS scores with the given value
  count_0 <- sum(subsystems == 0, na.rm = TRUE)       ## Number of FS scores equal to 0
  count_1 <- sum(subsystems == 1, na.rm = TRUE)       ## Number of FS scores equal to 1
  count_2 <- sum(subsystems == 2, na.rm = TRUE)       ## Number of FS scores equal to 2
  count_3 <- sum(subsystems == 3, na.rm = TRUE)       ## Number of FS scores equal to 3
  count_4 <- sum(subsystems == 4, na.rm = TRUE)       ## Number of FS scores equal to 4
  count_5_or_6 <- sum(subsystems %in% c(5, 6), na.rm = TRUE)  ## Number of FS scores equal to 5 or 6
  
  ## Check for any NA in subsystems or score_ambulation
  if (any(is.na(subsystems)) || is.na(score_ambulation)) {
    return(NA)
  }
  
  ## EDSS calculation logic
  if (count_0 == 7 && score_ambulation == 0) {
    return(0) 
    ## All FS scores = 0 and Ambulation score = 0
  } else if (count_1 == 1 && all(subsystems <= 1) && score_ambulation == 0) {
    return(1) 
    ## Exactly one FS score = 1, others ≤ 1, Ambulation score = 0
  } else if (count_1 >= 2 && all(subsystems <= 1) && score_ambulation == 0) {
    return(1.5)
    ## Two or more FS scores = 1, all FS scores ≤ 1, Ambulation score = 0
  } else if (count_2 == 1 && all(subsystems <= 2) && score_ambulation %in% c(0, 1)) {
    return(2)
    ## Exactly one FS score = 2, others ≤ 2, Ambulation score = 0 or 1
  } else if (count_2 == 2 && all(subsystems <= 2) && score_ambulation %in% c(0, 1)) {
    return(2.5)
    ## Exactly two FS scores = 2, others ≤ 2, Ambulation score = 0 or 1
  } else if (count_3 == 1 && count_2 == 0 && all(subsystems <= 3) && score_ambulation %in% c(0, 1)) {
    return(3)
    ## Exactly one FS score = 3, no FS score = 2, others ≤ 3, Ambulation score = 0 or 1
  } else if (count_2 >= 3 && count_2 <= 4 && all(subsystems <= 2) && score_ambulation %in% c(0, 1)) {
    return(3)
    ## Three or four FS scores = 2, others ≤ 2, Ambulation score = 0 or 1
  } else if (count_3 == 1 && count_2 >= 1 && count_2 <= 2 && all(subsystems <= 3) &&
             score_ambulation %in% c(0, 1)) {
    return(3.5)
    ## Exactly one FS score = 3, one or two FS scores = 2, others ≤ 3, Ambulation score = 0 or 1
  } else if (count_3 == 2 && count_2 == 0 && all(subsystems <= 3) && score_ambulation %in% c(0, 1)) {
    return(3.5)
    ## Exactly two FS scores = 3, no FS score = 2, others ≤ 3, Ambulation score = 0 or 1
  } else if (count_2 == 5 && all(subsystems <= 2) && score_ambulation %in% c(0, 1)) {
    return(3.5)
    ## Exactly five FS scores = 2, no FS higher than 2, Ambulation score = 0 or 1
  } else if (count_2 >= 6 && count_2 <= 7 && all(subsystems <= 2) && score_ambulation %in% c(0, 1)) {
    return(4)
    ## Six or seven FS scores = 2, no FS higher than 2, Ambulation score = 0 or 1
  } else if (count_3 >= 1 && count_3 <= 4 && all(subsystems <= 3) && score_ambulation %in% c(0, 1)) {
    return(4)
    ## One to four FS scores = 3, no FS higher than 3, Ambulation score = 0 or 1
  } else if (count_3 == 0 && count_4 == 1 && all(subsystems <= 4) && score_ambulation %in% c(0, 1)) {
    return(4)
    ## Exactly one FS score = 4, no FS score = 3, others ≤ 4, Ambulation score = 0 or 1
  } else if (count_3 == 5 && all(subsystems <= 3) && score_ambulation %in% c(0, 1, 2)) {
    return(4.5)
    ## Exactly five FS scores = 3, no FS higher than 3, Ambulation score = 0, 1, or 2
  } else if (count_3 >= 1 && count_3 <= 4 && count_4 == 1 && all(subsystems <= 4) &&
             score_ambulation %in% c(0, 1, 2)) {
    return(4.5)
    ## One to four FS scores = 3, one FS score = 4, others ≤ 4, Ambulation score = 0, 1, or 2
  } else if (score_ambulation == 2) {
    return(4.5) 
    ## Ambulation score = 2, EDSS = 4.5
  } else if (score_ambulation == 3) {
    return(5) 
    ## Ambulation score = 3, EDSS = 5
  } else if (count_5_or_6 >= 1 && score_ambulation %in% c(0, 1, 2, 3)) {
    return(5)
    ## One or more FS scores = 5 or 6, Ambulation score = 0, 1, 2, or 3
  } else if (count_3 >= 6 && count_3 <= 7 && all(subsystems <= 3) &&
             score_ambulation %in% c(0, 1, 2, 3)) {
    return(5)
    ## Six or seven FS scores = 3, no FS higher than 3, Ambulation score = 0, 1, 2, or 3
  } else if (count_4 >= 2 && count_4 <= 7 && all(subsystems <= 4) &&
             score_ambulation %in% c(0, 1, 2, 3)) {
    return(5)
    ## Two to seven FS scores = 4, no FS higher than 4, Ambulation score = 0, 1, 2, or 3
  } else if (score_ambulation == 4) {
    return(5.5) 
    ## Ambulation score = 4, EDSS = 5.5
  } else if (score_ambulation %in% c(5, 6, 7)) {
    return(6)
    ## Ambulation score = 5, 6, or 7, EDSS = 6
  } else if (score_ambulation %in% c(8, 9)) {
    return(6.5)
    ## Ambulation score = 8 or 9, EDSS = 6.5
  } else if (score_ambulation == 10) {
    return(7)
    ## Ambulation score = 10, EDSS = 7
  } else if (score_ambulation == 11) {
    return(7.5)
    ## Ambulation score = 11, EDSS = 7.5
  } else if (score_ambulation == 12) {
    return(8)
    ## Ambulation score = 12, EDSS = 8
  } else if (score_ambulation == 13) {
    return(8.5)
    ## Ambulation score = 13, EDSS = 8.5
  } else if (score_ambulation == 14) {
    return(9)
    ## Ambulation score = 14, EDSS = 9
  } else if (score_ambulation == 15) {
    return(9.5)
    ## Ambulation score = 15, EDSS = 9.5
  } else if (score_ambulation == 16) {
    return(10)
    ## Ambulation score = 16, EDSS = 10
  } else {
    return(NA) 
    ## Default value - NA in error cases (cases that do not fit any condition)
  }
}

# Example - calculation of EDSS from Functional Scores
score_pyramidal <- 1
score_cerebellar <- 0
score_brain_stem <- 1
score_sensory <- 1
score_bowel_bladder <- 0
score_visual <- 0
score_mental <- 1
score_ambulation <- 1

edss_total <- edss_calculation(
  score_pyramidal, score_cerebellar, score_brain_stem, score_sensory,
  score_bowel_bladder, score_visual, score_mental, score_ambulation
)
print(edss_total)