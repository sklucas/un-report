# Setup

library(tidyverse)

# Understanding Commands

gapminder_1997 <- read_csv("code/gapminder_1997.csv")
spec(gapminder_1997)

?read_csv()
Sys.Date()
getwd()

round(3.1415)
round(3.1415,3)

# Creating our first plot
ggplot(data = gapminder_1997) +
  aes(x = gdpPercap) +
  labs(x = "GDP Per Capita") +
  aes(y = lifeExp) +
  labs(y = "Life Expectancy") +
  geom_point() +
  labs(title = "Do people in wealthy countries live longer?") +
  aes(color = continent) +
  scale_color_brewer(palette = "Set1") +
  aes(size = pop/1000000) +
  labs(size = "Population (in millions)")

# condensed
ggplot(data = gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp, color = continent, size = pop/1000000) +
  geom_point() +
  scale_color_brewer(palette = "Set1") +
  labs(x = "GDP Per Capita", y = "Life Expectancy",
       title = "Do people in wealthy countries live longer?", size = "Population (in millions)")

# Plotting for data exploration

## Importing datasets

gapminder_data <- read_csv("code/gapminder_data.csv")
dim(gapminder_data)
head(gapminder_data)

ggplot(data = gapminder_data) +
  aes(x=year, y=lifeExp, color=continent) +
  geom_point()

str(gapminder_data)

ggplot(data = gapminder_data) +
  aes(x = year, y = lifeExp, color = continent) +
  geom_line()

ggplot(data = gapminder_data) +
  aes(x = year, y = lifeExp, group = country, color = continent) +
  geom_line()

## Discrete plots

ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_boxplot()

## Layers

ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_violin()

ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_violin() +
  geom_point()

ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_violin() +
  geom_jitter()

ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_jitter() +
  geom_violin()

ggplot(data = gapminder_1997, mapping = aes(x = continent, y = lifeExp)) +
  geom_violin() +
  geom_jitter()

ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_violin() +
  geom_jitter(aes(size = pop))

## Color vs. Fill

ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_violin(color="pink")

ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_violin(fill="pink")

ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_violin(aes(fill=continent))


## Univariate plots

ggplot(gapminder_1997) +
  aes(x = lifeExp) +
  geom_histogram()

ggplot(gapminder_1997) +
  aes(x = lifeExp) +
  geom_histogram(bins=20)

## Plot themes

ggplot(gapminder_1997) +
  aes(x = lifeExp) +
  geom_histogram(bins = 20) +
  theme_classic()

## Facets

ggplot(gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp) +
  geom_point()

ggplot(gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp) +
  geom_point() +
  facet_wrap(vars(continent))

ggplot(gapminder_1997) +
  aes(x = gdpPercap, y = lifeExp) +
  geom_point() +
  facet_wrap(vars(continent))
  
## Saving plots
  
ggsave("figures/awesome_plot.jpg", width=6, height=4)

ggplot(gapminder_1997) +
  aes(x = lifeExp) +
  geom_histogram(bins = 20)+
  theme_classic()

ggsave("figures/awesome_histogram.jpg", width=6, height=4)

violin_plot <- ggplot(data = gapminder_1997) +
  aes(x = continent, y = lifeExp) +
  geom_violin(aes(fill=continent))

violin_plot + theme_bw()

violin_plot <- violin_plot + theme_bw()

ggsave("figures/awesome_violin_plot.jpg", plot = violin_plot, width=6, height=4)

my_plot <- ggplot(data = gapminder_1997)+
  aes(x = continent, y = gdpPercap)+
  geom_boxplot(fill = "orange")+
  theme_bw()+
  labs(x = "Continent", y = "GDP Per Capita")

ggsave("figures/my_awesome_plot.jpg", plot = my_plot, width=6, height=4)


# Bonus
## Creating complex plots
### Animated plots

install.packages(c("gganimate", "gifski"))
library(gganimate)
library(gifski)

staticHansPlot <- ggplot(data = gapminder_data)+
  aes(x = log(gdpPercap), y = lifeExp, size = pop/1000000, color = continent)+
  geom_point(alpha = 0.5) + # we made our points slightly transparent, because it makes it easier to see overlapping points
  scale_color_brewer(palette = "Set1") +
  labs(x = "GDP Per Capita", y = "Life Expectancy", color= "Continent", size="Population (in millions)")+
  theme_classic()

staticHansPlot

animatedHansPlot <- staticHansPlot +
  transition_states(year,  transition_length = 1, state_length = 1)+
  ggtitle("{closest_state}")

animatedHansPlot

anim_save("figures/hansAnimatedPlot.gif", 
          plot = animatedHansPlot,
          renderer = gifski_renderer())
