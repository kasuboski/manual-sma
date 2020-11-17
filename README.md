# Manual SMA

Container to run [mdhiggins/sickbeard_mp4_automator](https://github.com/mdhiggins/sickbeard_mp4_automator).

## Usage
Auto convert a folder:

`docker run -it --rm -v /my/media/show:/convert manual-sma -i /convert -a`

For more info read the manual usage [section](https://github.com/mdhiggins/sickbeard_mp4_automator#manual-script-usage).

Most of the Dockerfile is from [mdhiggins/radarr-sma](https://github.com/mdhiggins/radarr-sma). I just didn't want radarr or anything like that.