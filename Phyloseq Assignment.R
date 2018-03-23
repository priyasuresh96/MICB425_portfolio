library(tidyverse)
source("https://bioconductor.org/biocLite.R")
biocLite("phyloseq")
library(phyloseq)
load("phyloseq_object.RData")

##Excersice 1
ggplot(metadata, aes(x=NH4_uM, y=Depth_m)) +
  geom_point(color="purple") + 
  geom_point(shape=2)

##Excercise 2
metadata %>%
  select(matches("temp|temperature"))
metadata %>%
  mutate(Temperature_C = (Temperature_C*1.8)+32) %>%
  ggplot() + geom_point(aes(x=Temperature_C, y=Depth_m))

plot_bar(physeq, fill="Phylum")
physeq_percent = transform_sample_counts(physeq, function(x) 100 * x/sum(x))
plot_bar(physeq_percent, fill="Phylum")
plot_bar(physeq_percent, fill="Phylum") + 
  geom_bar(aes(fill=Phylum), stat="identity")


##Excercise 3
plot_bar(physeq_percent, fill="Domain") + 
  geom_bar(aes(fill=Phylum), stat="identity") +
  ggtitle("Domain from 10 to 200 m in Saanich Inlet") + xlab("Sample depth") + ylab("Percent relative abundance")


##Faceting
plot_bar(physeq_percent, fill="Phylum") +
  geom_bar(aes(fill=Phylum), stat="identity") +
  facet_wrap(~Phylum)

plot_bar(physeq_percent, fill="Phylum") +
  geom_bar(aes(fill=Phylum), stat="identity") +
  facet_wrap(~Phylum, scales="free_y") +
  theme(legend.position="none")

#Excercise 4

table= meta

table= metadata %>% 
  select(Depth_m, O2_uM, PO4_uM, SiO2_uM, NO3_uM, NH4_uM, NO2_uM)

table_1= table %>% 
  gather(Nutrients, Concentration, O2_uM, PO4_uM, SiO2_uM, NO3_uM, NH4_uM, NO2_uM)

library(tidyverse)
library(phyloseq)

ggplot(table_1, aes(x=Depth_m, y=Concentration)) +
  geom_point() + geom_line()+ facet_wrap(~Nutrients, scales="free_y") +
  theme(legend.position="none")



