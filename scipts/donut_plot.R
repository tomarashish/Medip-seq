df = data.frame(count=c(25, 75), 
                category=c("A", "B")) 

# basic pie chart 
p1 <- ggplot(df, aes(x = factor(1), fill = category, weight=count)) +    
  geom_bar(width = 1) +  
  coord_polar(theta="y") +  
  scale_x_discrete("") +                                                                                          # remove y label         
  theme(axis.ticks = element_blank(),                                                             # remove tick marks      
        axis.text.y = element_blank())                                                                  # remove y axis marks 
print(p1)        

# donut chart 
df$fraction = df$count / sum(df$count)                                                                  # create fraction column 
df = df[order(df$fraction), ]                                                                                   # sort dataframe by fraction 
df$ymax = cumsum(df$fraction)                                                                                   # set end for each fraction              
df$ymin = c(0, head(df$ymax, n=-1))                                                                             # set start for each fraction 
p2 <- ggplot(df, aes(fill=category, ymax=ymax, ymin=ymin, xmax=4, xmin=3)) + 
  geom_rect() + 
  coord_polar(theta="y") + 
  xlim(c(0, 4)) + 
  theme(panel.grid=element_blank()) +                                                            # remove grid from plot 
  theme(axis.ticks=element_blank()) 
print(p2)