#!/bin/bash
### https://github.com/BelkaDev/musicstream ###

function NetException
{
  if [[ $? = 6 ]]; then
    echo "NetworkError: couldn't reach server."
    exit
  fi
}

function author_name(){
 echo $(echo $( echo "$1")   | grep -oh -P '(?<=a playlist by ).*?"'| awk -F"on Spotify" '{print $1}')
}
function artist_name()
{
 echo $(echo $( echo "$1")   | grep -oh -P '(?<=a song by ).*' | awk -F"on Spotify" '{print $1}')

}
function album_artist_name(){
 echo $(echo $( echo "$1")   | grep -oh -P '(?<=an album by ).*?"'| awk -F"on Spotify" '{print $1}' | head -1)
}

function current_list()
{
echo $(echo $( echo "$1")  | grep -oh -P '(?<="name":").*(?=","description")' ) 
}

function tracks_number()
{ 
 echo $(echo $( echo "$1")    | grep -oh -P '(?<="track_number").*?}'|sed s'/.$//' | sed 's/^/"track_id": /' | cut -d, -f1,3 | wc -l)
}

if [[ -z $(pidof -s spotify) ]]; then
  echo "Spotify is not running."
  exit
fi
arg=track
engine=https://www.google.com
if [[ ${1^^} =~ ^(-A|--ALBUM|ALBUM)$ ]]; then
  arg=album
  shift
elif [[ ${1^^} =~ ^(-P|--PLAYLIST|PLAYLIST|SOME)$ ]]; then
  arg=playlist
  shift
fi

if [[ $* == *"open.spotify.com/playlist/"* ]]; then
arg=playlist
key=$(echo $* | sed 's:.*/::' | cut -c 1-22)
else

#################################
# if you have googler installed (https://github.com/jarun/googler)
#  switch out the two methods 
#################################
#-----cURL method-----#
req=$engine"/search?hl=en&q=$(echo $* | sed 's/ /+/g')"+"site:open.spotify.com/"$arg
key=$(curl  -sA "FF" $req | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | \
  sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'  | grep -i 'open.spotify.com/'$arg/ | grep -i 'https'  -m 1  | sed 's:.*/::' | cut -c 1-22)

#################################
#----googler method-----#  
#sq=$( googler --np -n  5 -w https://open.spotify.com/$arg $*)
#key=$(echo "$sq" | grep -i 'https' -m 1 | sed 's:.*/::' | sed 's:?.*::' )
#################################
fi
link=https://open.spotify.com/$arg/$key
curr=$(curl -s $link)
NetException
if [[ $(echo "$curr" | grep -m 1 -o "error") = "error" || $(echo "$curr" | grep -m 1 -o "Moved Permanently") = "Moved Permanently" ]]; then
      echo "Couldn't find any $arg with given info."
      exit
else
dbus-send  --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.OpenUri string:spotify:$arg:$key &>/dev/null

########################Output########################  
      echo "------Queued ${arg^}------"
if [[ $arg = "track" ]]; then
      echo "Artist : $(artist_name "$curr")"
      echo "Track name : $(current_list "$curr")"
      echo "added $(tracks_number "$curr") track to queue."
elif [[ $arg = "album" ]]; then
      echo "Artist : $(album_artist_name "$curr")"
      echo "Album : $(current_list "$curr")"
      echo "added $(tracks_number "$curr") tracks to queue."
elif [[ $arg = "playlist" ]]; then
#    echo "Playlist author : $(author_name "$curr")"
      echo "Playlist name : $(current_list "$curr")"
      echo "Playlist URL : $link"
      echo "added $(tracks_number "$curr") tracks to queue."
###################################################### 
fi
fi
