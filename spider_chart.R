# Libraries
library(plotly)
library(DBI)
library(tidyr)
library(dplyr)

# create data frame with random numbers
df <- data.frame(replicate(2, sample(50:150, 12, rep = TRUE)))
colnames(df) <- c("A","B")

# Create the labels
months <- c('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December')

# Font settings 
f <- list(
  color = 'white'
)

# Margin settings to be called later on
m <- list(
  l = 60,
  r = 10,
  b = 60, 
  t = 60,
  pad = 4
)

# Initiate chart
spider <- plot_ly(
  # Scatterpolar is Plotly's name for spiderchart
  type = 'scatterpolar',
  fill = 'toself'
) %>%
  # Add trace for first variable
  add_trace(
    # Data for the trace is the values of change for each month, second argument is the first data point (Jan.) to connect full circle
    r = c(df$A, df$A[1]),
    theta = c(months, months[1]),
    name = 'A',
    # RGBA includes the fourth argument which is alpha (opacity)
    fillcolor = 'rgba(255, 107, 0, .3)',
    # mode modifies the data point markers
    mode = 'none'
  ) %>%
  # Add trace for second variable
  add_trace(
    r = c(df$B, df$B[1]),
    theta = c(months, months[1]),
    name = 'B',
    # RGBA includes the fourth argument which is alpha (opacity)
    fillcolor = 'rgba(255, 241, 0,.3)',
    # mode modifies the data point markers
    mode = 'none'
  ) %>%
  # Plot Layout options
  layout(
    polar = list(
      bgcolor = 'rgba(0,0,0,0)',
      radialaxis = list(
        visible = T,
        gridcolor = 'white',
        zerolinecolor = 'white',
        # Flat axis label font
        tickfont = f,
        # Title font
        titlefont = f,
        # Add the '%' character after the tick labels on the horizontal axxis
        # ticksuffix = '%',
        tickmode = "linear",
        # Starting tick
        tick0 = 0,
        # The interval between ticks 
        dtick = 50,
        # The range of the axis - added buffer at the end so that the tick labels do not collide with data labels
        range = c(0,175)
      ),
      angularaxis = list(
        gridcolor = 'white',
        linewidth = 0,
        # Outermost line color
        linecolor = 'white',
        tickcolor = 'white',
        ticklabel = 'white',
        tickfont = f,
        titlefont = f,
        direction = 'clockwise'
      )
    )
    ,
    showlegend = FALSE,
    margin = m
    # transparent background
    # ,paper_bgcolor = 'rgba(0,0,0,0)'
    # Background color of the plot output
    ,paper_bgcolor = '#626262'
  )

# Display the chart
spider
