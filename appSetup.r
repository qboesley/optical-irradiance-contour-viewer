# Create folders to download app components to. The folder 'OptoContourViewerApp' will be created in your R working directory.
cat("Creating folders for app components\n")
dir.create(file.path('OptoContourViewerApp', 'data'), recursive = TRUE)

# download app.R file into directory
#update the url and destfile to access the local version of the app
cat("Downloading app file\n")
download.file("https://github.com/qboesley/optical-irradiance-contour-viewer/blob/main/localApp.r?raw=1", destfile = file.path('OptoContourViewerApp', 'localApp.R'))

# download white and grey matter data files into the data directory
cat("Downloading data files:\n")
cat("grey.mat\n")
download.file("https://brainstimulation.github.io/optical-irradiance-contour-webapp/data/grey.mat?raw=1", destfile = file.path('OptoContourViewerApp', 'data', 'grey.mat'), quiet = TRUE, mode = 'wb')
cat("white.mat\n")
download.file("https://brainstimulation.github.io/optical-irradiance-contour-webapp/data/white.mat?raw=1", destfile = file.path('OptoContourViewerApp', 'data', 'white.mat'), quiet = TRUE, mode = 'wb')

# install required packages
# https://stackoverflow.com/questions/4090169/elegant-way-to-check-for-missing-packages-and-install-them
cat("Installing necessary packages\n")
requiredpackages <- c("shiny", "bslib", "R.matlab")
notyetinstalled <- requiredpackages[!(requiredpackages %in% requiredpackages()[,"Package"])]
if(length(notyetinstalled)) install.packages(notyetinstalled, repos = "http://cran.us.r-project.org")

# exit message
cat("All app components downloaded! To start the app run the command below in this console:\n\nsource(file.path(\"OptoContourViewerApp\", \"localApp.R\"))")

