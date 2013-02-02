# Convert a Quick Time screencast to gif.
# NOTE: In Quick Time, use the export to "iPod touch & iPhone 3GS"
#       option. This will create a .m4v file which results in a
#       better gif than a .mov file.
#
# Dependencies:
#  % brew install ffmpeg gifsicle
#
# Props to http://schneems.com/post/41104255619/use-gifs-in-your-pull-request-for-good-not-evil
#      and http://www.reddit.com/r/ruby/comments/16zvjt/use_gifs_in_your_pull_request_for_good_not_evil/c81btvm
function gifify {
        src="$1"
        gif="$2"

        if [ "$src" = "" ] || [ "$gif" = "" ]; then
                echo "Usage: $0 [source file] [target.gif]"
                echo "Converts [source file] to gif file [target.gif]"
                return
        fi

        echo "Will create ${gif} from ${src}."
        echo -n "Ok? [y/n] "
        read ok

        if [ $ok != "y" ]; then
                return
        fi

        gifify_tmpdir=`mktemp -d ${TMPDIR-/tmp}/gifify.$$` || return
        orig_dir=`pwd`

        cd ${gifify_tmpdir} && \
        ffmpeg  -loglevel quiet -i "${orig_dir}/${src}" ${gifify_tmpdir}/%d.png && \
        for i in ${gifify_tmpdir}/*.png ; do convert $i $i.gif ; done && \
        gifsicle --colors 256 -O3 -Okeep-empty -d2 -l $(ls *.png.gif |sort -g) > ${orig_dir}/$gif

        cd ${orig_dir}

        rm ${gifify_tmpdir}/*.{png.gif,png} && rmdir ${gifify_tmpdir}

        echo "Created ${gif}."
}
