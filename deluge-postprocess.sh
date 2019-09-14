#!/bin/bash

# Input Parameters & Folder Configuration
SERIES_INPUT="/mnt/downloads/deluge/complete/flexget/series"
SERIES_OUTPUT="/mnt/video/documentary/series"
MOVIES_INPUT="/mnt/downloads/deluge/complete/flexget/movies"
MOVIES_OUTPUT="/mnt/video/documentary/movies"
UNSORTED_OUTPUT="/mnt/video/documentary/unsorted"

filebot -script fn:amc --output "$SERIES_OUTPUT" --def "ut_label=series" --action copy --conflict override -non-strict --def artwork=n --def unsorted=y --def unsortedFormat="$MOVIE_INPUT/{fn}.{ext}" --def clean=y "ut_dir=$SERIES_INPUT" "ut_kind=multi" --def "seriesFormat=/mnt/video/documentary/series/{n}/{'S'+s.pad(2)}/{n.replaceAll(/[!?.]+$/).space('.')}.{'s'+s.pad(2)}e{e.pad(2)}.{vf}.{source}.{vc}.{ac}" --def excludeList="/home/media/.filebot/series_amc.txt" -no-xattr --log-file "/home/media/.filebot/amc.log" --def reportError=y > /home/media/.filebot/series_output.txt 2>&1

filebot -script fn:amc --output "$MOVIES_OUTPUT" --db TheMovieDB --def --action copy --conflict override -non-strict --def artwork=n --def excludeList="/home/media/.filebot/movies_amc.txt" --def unsorted=y --def unsortedFormat="$UNSORTED_OUTPUT/{fn}.{ext}" --def clean=y  --def "movieFormat=/mnt/video/documentary/movies/{ny}" "ut_dir=$MOVIES_INPUT" "ut_kind=multi" "ut_label=movies" -no-xattr --log-file "/home/media/.filebot/amc.log" --def reportError=y > /home/media/.filebot/movies_output.txt 2>&1
