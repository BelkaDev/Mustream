# Musicstream
A quick 'hack' to stream any music through the command line.


## <u> Caution: read before using! </u>
This script sends automated requests in order to extract data. </br>
you should use with caution not to get caught by a captcha: </br>
* don't do it too fast 
* use random delays between your queries. </br> </br>

While you can always reset your ISP, I'm not responsible if you </br>
get blocked from further scraping. (using a proxy is recommended.) </br>

## Description 
 This script will look up for the best available result given any keywords. </br>
 Ideally you should give the complete track info ( $artist - $song ) for more 
 accurate results. </br>
 No sign up or premium subscriptions are required, this is a small workaround 
 to Spotify API. </br>
 <img src="https://s3.gifyu.com/images/record.gif"> </img>
 
## Features:
Queue up any track/album/playlist from the spotify library.

## Usage :
Type a song title or artist name for a quick search. </br>
Add prefix Album/Playlist for respective results. </br>
You can direcly input a playlist URL. </br>
Spotify client must be running, there are many ways to hide </br>
it, depending your DE/WM. (cf. below)

## Tricks & notes :
* This script doesn't provide a client interface (pause,next,prev) </br>
I suggest you use SP (https://gist.github.com/wandernauta/6800547) for this </br>
purpose.
* If you want to queue a single artist playlist, </br>add prefix 'some' before to load 
a complete playlist, acronyms are accepted for popular bands </br>
   - `play some PF` will play a Pink Floyd playlist</br>
   - `play some NMH` will play a Neutral milk hotel playlist </br>
* To hide the (ugly) Spotify GUI you can try out these commands. (will work better on WM) </br>
  - `xdotool search --name spotify windowunmap`
  - `wmctrl -r "spotify" -b toggle,hidden`

## Installation :
Download the script </br>
Add it to your ~/.local/bin/ </br>
Change alias to "play" in your .bashrc/.zshrc
