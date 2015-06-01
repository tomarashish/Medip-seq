ggplot(mpg, aes(x=factor(1),fill=class)) + 
  +     geom_bar(width=.5) +  coord_polar(theta="y") +
  +     scale_fill_manual(values=classPalette) +
  +     xlab("") +
  +     ylab("") +
  +     ggtitle("Vehicles of Different Classes, 1999-2008") +
  +     theme(text=element_text(size=18,family="Times"),
              +           axis.ticks.y = element_blank(),
              +           axis.text.y = element_blank())