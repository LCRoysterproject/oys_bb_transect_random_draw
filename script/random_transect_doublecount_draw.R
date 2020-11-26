##### RANDOM DRAW FOR DOUBLE-COUNT TRANSECTS #####
##### UPDATE DATES AND FILE NAMES WHEN RUNNING THROUGH ###########

# import final transect draw data; "transect_draw_final_YYYY.csv" file
final_trans_draw <- read.csv("data/transect_draw_final_2020.csv")
trans_start <- final_trans_draw[which(final_trans_draw$TYPE == "TRAN_ST"), ]

# randomize all of the transects
trans_double_rand <- sample(nrow(trans_start))
trans_double <- trans_start[trans_double_rand, ]

# want to double-count 20% of transects
trans_dblcount_total <- nrow(trans_double) * 0.20
# select trans_dblcount_total (number) of rows from trans_double
# 2019 -- 18.2, so 18 double counted transects
# 2020 -- 37.4, so 37 double counted transects

# select trans_dblcount_total rows for double counting
here_we_go <- trans_double[1:round(trans_dblcount_total), ]
here_we_go

# save this file; "trans_dblcount_YYYY.csv"
write.csv(here_we_go, file="data/trans_dblcount_2020.csv")

