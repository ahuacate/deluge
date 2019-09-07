#!/bin/sh

# Input Parameters
ARG_PATH="$3/$2"
ARG_NAME="$2"
ARG_LABEL="N/A"


filebot -script fn:amc --log-file "/home/media/.config/filebot/amc.log" --def clean=y --output "/mnt/video/documentary/series" --action copy --conflict override -non-strict --def artwork=n "ut_dir=/mnt/downloads/deluge/complete/flexget/series" "ut_kind=multi" "ut_title=$TR_TORRENT_NAME" --def "seriesFormat=/mnt/video/documentary/series/{n}/{'S'+s.pad(2)}/{n.replaceAll(/[!?.]+$/).space('.')}.{'s'+s.pad(2)}e{e.pad(2)}.{vf}.{source}.{vc}.{ac}" --def reportError=y > /home/media/.config/filebot/output.txt 2>&1
