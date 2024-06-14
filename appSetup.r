# Create folders to download app components to. The folder 'OptoContourViewerApp' will be created in your R working directory.
cat("Creating folders for app components")
dir.create(file.path('OptoContourViewerApp', 'data'), recursive = TRUE)

# download app.R file into directory
#update the url and destfile to access the local version of the app
cat("Downloading app file\n")
download.file("https://github.com/BrainStimulation/optical-irradiance-contour-viewer/blob/main/src/app.R?raw=1", destfile = file.path('OptoContourViewerApp', 'app.R'))

# download white and grey matter data files into the data directory
cat("Downloading data files\n")
download.file("https://brainstimulation.github.io/optical-irradiance-contour-webapp/data/grey.mat?raw=1", destfile = file.path('OptoContourViewerApp', 'data', 'grey.mat'), quiet = TRUE, mode = 'wb')
download.file("https://brainstimulation.github.io/optical-irradiance-contour-webapp/data/white.mat?raw=1", destfile = file.path('OptoContourViewerApp', 'data', 'white.mat'), quiet = TRUE, mode = 'wb')

# install required packages
cat("Installing necessary packages\n")
install.packages("shiny", repos = "http://cran.us.r-project.org")
install.packages("bslib", repos = "http://cran.us.r-project.org")
install.packages("R.matlab", repos = "http://cran.us.r-project.org")

# exit message
cat("All app components downloaded! To start the app run the command below in this console:\n\nsource(\"localApp.R\")")

