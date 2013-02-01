# Convert a Quick Time screencast to GIF
# Creates two gifs, one HUGE and one optimized.
#
# Dependencies:
#  % brew install ffmpeg imagemagick
#
# Props to http://schneems.com/post/41104255619/use-gifs-in-your-pull-request-for-good-not-evil
function gifify {
        SRC="$1"
        DEST="$2"
        GIF="${DEST}.gif"
        GIF_HUGE="${DEST}-HUGE.gif"

        if [ "$SRC" = "" ] || [ "$DEST" = "" ]; then
                echo "Usage: $0 [source] [dest]"
                echo "Converts [source] to gif file [dest]"
                return
        fi

        echo "Will create ${GIF} and ${GIF_HUGE} from ${SRC}."
        echo -n "Ok? [y/n] "
        read OK

        if [ $OK != "y" ]; then
                return
        fi

        ffmpeg -i "${SRC}" -pix_fmt rgb24 "${GIF_HUGE}"
        convert -layers Optimize "${GIF_HUGE}" "${GIF}"

        echo "Created ${GIF}, you may remove the HUGE ${GIF_HUGE}."
}
