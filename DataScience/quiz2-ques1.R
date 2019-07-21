install.packages("jsonlite")
install.packages("httpuv")
install.packages("httr")

library(jsonlite)
library(httpuv)
library(httr)

# Can be github, linkedin etc depending on application
oauth_endpoints("github")

# Change based on your appname, key, and secret 
myapp <- oauth_app(appname = "Coursera majusus",
                   key = "73e35e4bc10f7af038c0",
                   secret = "94df55705b5d303e73a3243527d9595007993ac3")

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# Take action on http error
stop_for_status(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# Subset data.frame
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"]