# Overview
This app uses RShiny to visualise contour plots from my paper [PAPER NAME]

An online version is hosted [here](https://brainstimulation.github.io/optical-irradiance-contour-webapp/) and can be used directly in a web browser. It may take a few minutes for the app to open due to the size of the data files required.

This repository contains the files and instructions to run the app locally.

![image](https://github.com/qboesley/optical-irradiance-contour-viewer/assets/127060519/8d4ff816-b115-4046-ae3e-b83f5083fe01)

# Get started

## Prerequisites
Start by installing R, you can [download it from a mirror here](https://cran.r-project.org/mirrors.html). Tested on v4.4.0.

Next install RStudio, you can download it [here](https://posit.co/downloads/).

## Installing the app

1. Download the file `appSetup.R` from this repository.
2. In the RStudio console run the command `getwd()` which will print the current working directory to the console.
3. Move the `appSetup.R` file into this working directory. Alternatively, in RStudio you can press `ctrl + shift + h` or go to `Session > Set Working Directory > Choose Directory ... ` to set a different working directory, then move `appSetup.R` there.
4. In the RStudio console run the command `source("appSetup.R")`. This will create a folder `OptoContourViewerApp` in the working directory and download the app file and data files necessary to run the app locally.

## Running the app

### Using the RStudio console
Enter the command below into the RStudio console.
```
source(file.path("OptoContourViewerApp", "localApp.R"))
```

### Using the RStudio GUI
Navigate to the app in the files panel of RStudio `OptoContourViewerApp > localApp.R`, click on it and it will open in RStudio. Click on the `Run App` button at the top right of the panel the app file opened in.

# Using the App
## Input Options
The sidebar on the left hand side contains all the app controls. You may need to scroll down to see all of the options
- **Tissue Type** toggles between the grey matter and white matter simulation datasets.
- **Wavelength (nm)** toggles between the source wavelengths used in the simulations.
  - Note that 580 nm light is actually yellow rather than green, but it is plotted in green here for better visibility.
- **Light Source** is a drop down menu to select particular light sources. There are two main source types:
  - Optical Fibres, abbreviated as OF. The length in brackets refers to the diameter and NA is the numeric aperture.
  - LEDs. These were all modelled as square light sources. The length in brackets refers to the edge length of the square.
- **Total Optical Power (mW)** sets the total power output from the light source. The user can type values in to the box. You can also use the clicker icons, or scroll the mouse wheel to change the value by 0.1 mW at a time.
- **Threshold Irradiance (mW/mm^2)** sets the irradiance value to draw the contour line at. The user can type values in to the box. You can also use the clicker icons, or scroll the mouse wheel to change the value by 0.1 mW at a time.
- **Show Gridlines** turns gridlines on or off on the plot. Lines are plotted in 0.1 mm intervals.
- **Show Irradiance Plot Location** shows the location the irradiance profile plot (on the right hand side) is drawn from.
- **Logarithmic Irradiance Plot** switches the x axis of the irradiance profile plot between linear and logarithmic (base 10) scales.
- **Irradiance Plot Location** sets the lateral position on the contour plot from which to draw the irradiance profile. You can click and drag on the blue dot on the slider. If you click on the blue dot you can then use the arrow keys on your keyboard to move the slider.
- **Download Contour Plot** button will save the currently displayed contour plot as a .png file. The filename is automatically generated.
  - General format: {SourceInfo}\_{TissueType}_{Wavelength}nm_P{SourcePower}_T{ThresholdValue}_G{GridlineStatus}_X{IrradianceProfileLocation}mm_CONTOUR.png
  - LED example: `L-0500_W_480nm_P1-00_T1-00_Gon_X0-00mm_CONTOUR.png` is the 500 µm edge length LED source in white matter at 480 nm with 1 mW source power and a contour line at 1 mW/mm^2 with gridlines.
  - Optical fibre example: `OF_0200_37_G580nm_P2-30_T1-30_Goff_X0-13_CONTOUR.png` is the 200 µm diameter, NA = 0.37, optical fibre source in grey matter at 580 nm with 2.3 mW source power and a contour line at 1.3 mW/mm^2 with no gridlines.
  - Decimal points in {SourcePower} are replaced by hyphens (-)
- **Download Irradiance Plot** button will save the currently displayed irradiance plot as a .png file. The filename is automatically generated.
  - The corresponding irradiance plot names for the examples above are
  - `L-0500_W_480nm_P1-00_T1-00_Gon_Son_X0-00mm_IRRADIANCE_LIN.png`Irradiance plot with linear scale.
  - `F-0200-37_G_580nm_P2-30_T1-30_Goff_Soff_X0-13mm_IRRADIANCE_LOG.png`Irradiance plot with log scale.
 
## Outputs
Whenever any options are changed the contour plot, irradiance profile plot, and summary data are updated automatically.

If the app window is resized the aspect ratio of the plots will change. Updating any of the input options will redraw the plot with a square aspect ratio again.

The light source dimensions (diamter for optical fibres, edge length for LEDs) are drawn on the plot as a black horizontal line. 
The following summary data are included below the contour plot:
- **Max Irradiance** is the maximum irradiance at a single point within the model domain.
- **Vol. illuminated** is the volume of tissue illuminated over the specified threshold value.
- **Forward spread** is the maximum distance 'forwards' from the light source (i.e. positive depth value on the y-axis) with irradiance equal to or greater than the threshold value.
- **Backward spread** is the maximum distance 'backwards' from the light source (i.e. positive depth value on the y-axis) with irradiance equal to or greater than the threshold value.
- **Lateral spread** is the maximum distance 'sideways' from the light source (i.e. distance on the x-axis) with irradiance equal to or greater than the threshold value. The full extent of lateral spread is twice this value.

## Limitations
These are discussed extensively in the paper. A shortened list is given here:
- The max irradiance values calculated for the LED sources below are drastically underestimated. This is because the key dimension of these sources is equal to or less than the resolution of the original model (10 µm).
  - LED (1 µm)
  - LED (2 µm)
  - LED (5 µm)
  - LED (10 µm)
- Higher optical power values and lower irradiance threshold values may result in contours that do not fit within the 2&nbsp;mm&nbsp;x&nbsp;2&nbsp;mm plot region. When this occurs the max irradiance value is still correct, but the volume illuminated calculation will be incorrect. Values for forward, backward, and lateral spread will not increase beyond 1.00 mm either and so the relevant parameters will be incorrect when contours do not fit within the plot region.
- As contour lines get closer to the edge of the plot region, they tend to become more ragged. The reported values for light spread in these cases will overestimate the 'true' spread of light. For example, in the figure below backward spread is reported to be 0.59&nbsp;mm but I would offer approximately 0.45&nbsp;mm as a more resonable estimate in this instance.
![image](https://github.com/qboesley/optical-irradiance-contour-viewer/assets/127060519/39586fec-6e25-4571-98dd-5d00a08c708a)



