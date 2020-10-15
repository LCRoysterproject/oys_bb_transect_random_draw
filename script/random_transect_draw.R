##### RANDOM TRANSECT SELECTION FOR BIG BEND OYSTER SAMPLING #####
##### UPDATE DATES AND FILE NAMES WHEN RUNNING THROUGH ###########

##### WILD REEF RANDOM DRAWS #####
# "harvest_trans.csv" and "nonharvest_trans.csv" include all 
# possible wild reef transects (2x2 meter grid) from ArcGIS
# shapefile ("wildreef_fishnet_clip_sep.shp");
# this is in the shapefiles folder in the repo

### no harvest area ###
# read in all possible no harvest trans
NN_harv_trans <- read.csv("data/nonharvest_trans.csv")   
# min trans length 10m per 18Nov2018 email from Peter Frederick
NN_harv_trans <- NN_harv_trans[which(NN_harv_trans$LENGTH >= 10), ]  
# randomize ArcGIS output file
NN_harv_rand <- sample(nrow(NN_harv_trans))
NN_harv_trans <- NN_harv_trans[NN_harv_rand, ]
# export randomized file for each draw in the data folder as wild_reef_trans_NN_YYYY.csv
write.csv(NN_harv_trans, file = "data/wild_reef_trans_NN_2020.csv")

### harvest area ###
# read in all possible harvest trans
YN_harv_trans <- read.csv("data/harvest_trans.csv")   
# min trans length 10m per 18Nov2018 email
YN_harv_trans <- YN_harv_trans[which(YN_harv_trans$LENGTH >= 10), ]  
# randomize ArcGIS output file
YN_harv_rand <- sample(nrow(YN_harv_trans))
YN_harv_trans <- YN_harv_trans[YN_harv_rand, ]
# export randomized file for each draw in the data folder as wild_reef_trans_YN_YYYY.csv
write.csv(YN_harv_trans, file = "data/wild_reef_trans_YN_2020.csv")

########## IMPORTANT ##########
#' in exported files, each row is a transect; start at the top and sum
#' until target total transect length is reached; 
#' export to "transect_draw_final_YYYY.csv" file; 
#' format with the following columns: 
#' station, transect, epoch, rock, harvest, length, start_x, start_y, end_x, end_y
#' add Epoch 1/Spring 2018 transects:
#' LCI1-1 (NN), LCI2 (YN), LCI3 (YN), 
#' LCI4 (YN), LCI5 (YN), LCI6 (YN), LCN1 (YN), 
#' LCN2 (YN), LCN3 (YN), LCN4 (YN), LCN5 (YN), 
#' LCN6 (YN), LCN9 (YN)
#' save "transect_draw_final_YYYY.csv" file in the data folder;
#' import into Arc and fill in missing values, ensuring unique bar/transect
#' numbers from previous year draws



##### LCR RANDOM DRAWS #####

# transplant of live oysters occurred on elements 2-4, so these are excluded

### winter 2019-2020 sampling
# proportional allocation of X meters of transect by area
# Elements 5-16:   No Harvest, Rock (NY):   15,310 sq m   (56%)
NY_prop <- 0.56   # this wont change
# Elements 17-22:  Harvest, Rock (YY):      12,055 sq m   (44%)
YY_prop <- 0.44   # this wont change
# Total:                                   27,355 sq m

# transect total length to be sampled
# lcr_trans_tl <- 1049
# NY_trans_tl <- lcr_trans_tl * NY_prop
# YY_trans_tl <- lcr_trans_tl * YY_prop

# transect total length to be sampled via power analysis
# (need to be updated based on most recent power analysis)
YY_trans_tl <- 1150
NY_trans_tl <- 884
# number of transects to be sampled (all 22 meter transects)
ind_trans_tl <- 22
NY_trans <- NY_trans_tl / ind_trans_tl
YY_trans <- YY_trans_tl / ind_trans_tl

# "lc_centerline_seg.csv" is from splitting strata center-lines 
# into 22 meter segments in ArcGIS
lcr_seg <- read.csv("data/lc_centerline_seg.csv")
# no harvest, yes rock
lcr_seg_NY <- lcr_seg[which(lcr_seg$ELEMENT == "str1" | 
                             lcr_seg$ELEMENT == "str2"), ]
# yes harvest, yes rock
lcr_seg_YY <- lcr_seg[which(lcr_seg$ELEMENT == "str3"), ]

# calculate total possible transect length for NY and YY
tot_possible_trans_NY <- sum(lcr_seg_NY$LENGTH) * 5
tot_possible_trans_YY <- sum(lcr_seg_YY$LENGTH) * 5


### random draw no harvest, yes rocks; NY ###
lcr_NY_rand <- sample(nrow(lcr_seg_NY))
# randomize ArcGIS output file
lcr_seg_NY <- lcr_seg_NY[lcr_NY_rand, ]
# allow for 5 possible transects in each 22 meter reef segment
rand_trans_num <- data.frame(TRANS_NUM = sample(1:5, nrow(lcr_seg_NY), 
                                                replace = TRUE))
# combine 
rand_trans_num$SEG <- lcr_seg_NY$SEG
lcr_trans_NY <- merge(lcr_seg_NY, 
                      rand_trans_num, 
                      by.x = "SEG", 
                      sort = FALSE)
# calculate tran tl per segment based on number of trans assigned to each segment
lcr_trans_NY$TOT_LENGTH <- lcr_trans_NY$LENGTH * lcr_trans_NY$TRANS_NUM
# look at the data
head(lcr_trans_NY)
# save this as a new .csv with the updated YYYY
write.csv(lcr_trans_NY, file = "data/lcr_trans_NY_2020.csv")



### random draw yes harvest, yes rocks ###
lcr_YY_rand <- sample(nrow(lcr_seg_YY))
# randomize ArcGIS output file
lcr_seg_YY <- lcr_seg_YY[lcr_YY_rand, 1:5]
# allow for 5 possible transects in each 22 meter reef segment
rand_trans_num <- data.frame(TRANS_NUM = sample(1:5, nrow(lcr_seg_YY),
                                                replace = TRUE))
# combine 
rand_trans_num$SEG <- lcr_seg_YY$SEG
lcr_trans_YY <- merge(lcr_seg_YY,
                      rand_trans_num, 
                      by.x = "SEG", 
                      sort = FALSE)
# calculate tran tl per segment based on number of trans assigned to each segment
lcr_trans_YY$TOT_LENGTH <- lcr_trans_YY$LENGTH * lcr_trans_YY$TRANS_NUM
# look at the data
head(lcr_trans_YY)
# save this as a new .csv with the updated YYYY
write.csv(lcr_trans_YY, file = "data/lcr_trans_YY_2020.csv")

########## IMPORTANT ##########
#' in exported files ("lcr_trans_NY_YYYY.csv" and "lcr_trans_YY_YYYY.csv"), 
#' each row is the north end of a plot, with the number of transects per plot 
#' and total length per plot shown; 
#' start at the top and sum until target total transect length is reached;
#' export that to "transect_NY_final.csv" and "transect_YY_final.csv" file;
#' format it with the following columns:
#' station, transect, epoch, rock, harvest, length, start_x, start_y, end_x, end_y;
#' add those final draws to "transect_draw_final_YYYY.csv" from the wild reef
#' section above this way "transect_draw_final_YYYY.csv" contains all random
#' transect draws for that year (YYYY). 
#' then add epoch 1 transects if not already added: LCO
#' import into ArcGIS; fill in missing values, ensuring unique bar/trans 
#' numbers from previous year draws


