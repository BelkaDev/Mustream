# Mustream

Small exploit to stream music from the spotify library using your terminal.

### Try it!
``` bash
curl -s https://raw.githubusercontent.com/BelkaDev/Mustream/master/play | sh -s Hung up
```

## Description 
 The script will look up for the most relevant result following a set of keywords. </br>
 Ideally you should specify the complete track info ( $artist - $title ) for more 
 accurate results. </br>
 No sign up nor premium subscriptions are required. </br> </br>
 <img src="record.gif"> </img>
 
## Features:
Queue up any track/album/playlist from the spotify library.

## Usage :
* Type a song title or artist name for a quick search. </br>
* Add prefix `Album`/`Playlist` for respective results. </br>
* You can direcly input a playlist URL. </br>
* Spotify client must be running. (cf. below on how to hide it).

## Notes and tricks :
* This script doesn't include a client manager </br>
I suggest you use SP (https://gist.github.com/wandernauta/6800547) for this
matter.
* you can explore playlists by adding the prefix `some`, this will return </br>
a playlist related to your input, this option offers more flexibility to your search </br>
as you can use it to look up for artists,tags,albums without restrictions. </br>
it's also a good way to get music recommendations. </br>
acronyms are valid for most cases: </br>
   - `play some PF` will queue up a Pink Floyd playlist</br>
   - `play some NMH` will queue up a Neutral milk hotel playlist </br>
* To hide the Spotify GUI you can try out these commands. (will work better on a WM) </br>
  - `xdotool search --name spotify windowunmap`
  - `wmctrl -r "spotify" -b toggle,hidden`
* Some songs may not start due to country restrictions.

## Installation :
#### AUR Package
The script is available in AUR for Archlinux users, you can install it with any AUR helper
```
yay -S mustream-git
```
#### From source
```
git clone https://github.com/BelkaDev/mustream ~/mustream && cd ~/mustream && chmod +x play
```
