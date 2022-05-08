# The scripts to make the figure for scite RUN

CWD: /rsrch3/home/leuk-rsrch/huryu/ToolSelfMade/SCITE_RUN/

# The example of the code for scite_run
ls ../data/*.txt | xargs realpath > TSVList
cat TSVList | xargs -i BsubM -n 20 -M 150 "tsvTK_to_SCITE.sh {}" SCITE_RUN_RENEWED
