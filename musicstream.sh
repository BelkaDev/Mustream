
#!/bin/sh

#sq=$( googler --np -n  5 -w https://open.spotify.com/track $*)
#key="spotify:track:"$(echo "$sq" | grep -i 'https' -m 1 | sed 's:.*/::' | sed 's:?.*::' )

  run spotify
  wmctrl -r "spotify" -b toggle,hidden

function NetException
{
  if [[ $? = 1 ]]; then
    echo "NetworkError: couldn't reach server."
    exit 1
  fi
}

function author_name(){
curl -s $1| grep -oh -P '(?<=a playlist by ).*?"'| awk -F"on" '{print $1}'
}

function current_list()
{
curl -s $1 | grep -oh -P '(?<="name":").*(?=","description")'
}

function count_list()
{ # returns trackid from tracknumber 
 curl -s $1 | grep -oh -P '(?<="track_number").*?}'|sed s'/.$//' | sed 's/^/"track_id": /' | cut -d, -f1,3 | wc -l
}

function current_data()
{
#################  CREDITS TO SP  (https://gist.github.com/wandernauta/6800547)
   dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata   | grep -Ev "^method"                           `# Ignore the first line.`   \
  | grep -Eo '("(.*)")|(\b[0-9][a-zA-Z0-9.]*\b)' `# Filter interesting fiels.`\
  | sed -E '2~2 a|'\
  | tr -d '\n'   \
  | sed -E 's/\|/\n/g'\
  | sed -E 's/(xesam:)|(mpris:)//'\
  | sed -E 's/^"//'\
  | sed -E 's/"$//'\
  | sed -E 's/"+/ : /'\
  | sed -E 's/ +/ /g'\
  | sed -e "s/\b\(.\)/\u\1/g"\
  | grep -w "$1"
}

arg="track"
engine="http://www.yahoo.com"
if [[ -z "$(pidof -s spotify)" ]]; then
echo "Spotify is not running."
exit 1
else 
xdotool search --name "spotify" windowunmap
# wmctrl -r "Spotify" -b toggle,hidden

fi

if [[ ${1^^} =~ ^(-A|-ALBUM|ALBUM)$ ]]; then
  arg="album"
  shift
 elif [[ ${1^^} =~ ^(-P|-PLAYLIST|PLAYLIST|SOME)$ ]]; then
    arg="playlist"
   shift
fi
#-----curl alternative-----#
#req=$engine"/search?hl=en&q=$(echo $* | sed 's/ /+/g')"+"site:open.spotify.com/"$arg
#key=$(curl  -sA "Chromium" $req | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | \
#  sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'  | grep -i 'open.spotify.com/'$arg | grep -i 'https'  -m 1  | sed 's:.*/::' | cut -c 1-22)
#----googler alternative-----#
sq=$( googler --np -n  5 -w https://open.spotify.com/$arg $*)
key=$(echo "$sq" | grep -i 'https' -m 1 | sed 's:.*/::' | sed 's:?.*::' )
echo $key


dbus-send  --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.OpenUri string:spotify:$arg:$key &>/dev/null
link=https://open.spotify.com/$arg/$key


if [[ $(curl -s $link | grep -m 1 -o "error") = "error" ]]; then
      CATCH=NetException
	echo "Couldn't find any $arg with given info."
else 
      $CATCH

if [[ $arg = "track" ]]; then
    echo "------Queued ${arg^}------"
	current_data "Artist"
	current_data "Title"
elif [[ $arg = "album" ]]; then
    echo "------Queued ${arg^}------"
        echo "($(count_list $link) tracks added to queue.)"
	current_data "Artist"
	current_data "Album"
elif [[ $arg = "playlist" ]]; then
      # echo "Name  : $(current_list $link)"
      # echo "Author : $(author_name $link)"
       echo  "$(count_list $link) tracks added to queue."
fi
fi

#key="spotify:track:"$(curl -sA "Chrome" 'http://www.google.com/search?hl=en&q=$*  ' |  grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | \
  #sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' | grep -i 'open.spotify.com/track'| grep -i 'https' -m 1 | sed 's:.*/::' | cut -d "&" -f 1)

  

#https://open.spotify.com/user/mirandarosembert/playlist/6gX64SJOiFhzYbHi4lmEYV 
