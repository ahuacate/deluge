#!/bin/bash

# Input Parameters & Folder Configuration
SERIES_INPUT="/mnt/downloads/deluge/complete/flexget/series"
SERIES_OUTPUT="/mnt/video/documentary/series"
MOVIE_INPUT="/mnt/downloads/deluge/complete/flexget/movies"
MOVIE_OUTPUT="/mnt/video/documentary/movies"

filebot -script fn:amc --output "$SERIES_OUTPUT" --def "ut_label=series" --action copy --conflict override -non-strict --def artwork=n --def clean=y "ut_dir=$SERIES_INPUT" "ut_kind=multi" --def "seriesFormat=/mnt/video/documentary/series/{n}/{'S'+s.pad(2)}/{n.replaceAll(/[!?.]+$/).space('.')}.{'s'+s.pad(2)}e{e.pad(2)}.{vf}.{source}.{vc}.{ac}" -no-xattr --log-file "/home/media/.filebot/amc.log" --def reportError=y > /home/media/.filebot/output.txt 2>&1

filebot -script fn:amc --output "$MOVIE_OUTPUT" --def "ut_label=movies" --action copy --conflict override -non-strict --def artwork=n --def clean=y "ut_dir=$MOVIE_INPUT" "ut_kind=multi" --def "movieFormat=/mnt/video/documentary/movies/{ny}/{n.upperInitial().replaceAll(/[!?.]+$/).space('.')}.{y}.{vf}.{source}.{vc}.{ac}" -no-xattr --log-file "/home/media/.filebot/amc.log" --def reportError=y > /home/media/.filebot/output.txt 2>&1
