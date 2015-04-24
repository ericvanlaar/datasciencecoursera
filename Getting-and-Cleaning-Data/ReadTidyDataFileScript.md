
### Reading tidy.txt

To read the tidy.txt file into R, copy & paste the following script into R:


`address <- "https://s3.amazonaws.com/coursera-uploads/user-98165093146c3d0d4a22dbc1/973500/asst-3/1a15ef50e61e11e488445170f2d2d5db.txt"`

`address <- sub("^https", "http", address)`

`data <- read.table(url(address), header = TRUE)`

`View(data)`

