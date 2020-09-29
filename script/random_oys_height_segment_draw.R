##### RANDOM DRAW FOR OYSTER HEIGHT DATA COLLECTION ON TRANSECTS #####
##### UPDATE DATES AND FILE NAMES WHEN RUNNING THROUGH ###########

# read in possible segments
rand_seg <- read.csv("data/rand_seg.csv")

# randomize segments
rand <- sample(rand_seg$segment, 150, replace = TRUE)

oys_ht_rand_seg <- data.frame(rand)
