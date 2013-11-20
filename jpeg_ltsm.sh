#!/bin/bash

NAME='Lossless JPEG transformation'
VERSION='0.9.1'


error_exit() {
    kdialog --title "$NAME" --error "Requires operation and file names, read '$0'."
    exit 1
}


init() {
    OPERATION="$1"
    TOTAL="$2"
    dcopRef=$(kdialog --title "$NAME ($OPERATION)" --progressbar "Initializing . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ." "$TOTAL")
    #dcopRef=$(kdialog --title "$NAME ($OPERATION)" --progressbar "Initializing . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ." "$TOTAL")
    qdbus $dcopRef org.kde.kdialog.ProgressDialog.showCancelButton true > /dev/null
    # qdbus $dcopRef org.freedesktop.DBus.Properties.Set org.kde.kdialog.ProgressDialog maximum "$TOTAL" > /dev/null
}


process() {
    OPERATION="$1"
    n=0
    while shift; do
        FILE="$1"
        [ -z "$FILE" ] && break

        canceled=$(qdbus $dcopRef org.kde.kdialog.ProgressDialog.wasCancelled)
        if [ "$canceled" == "true" ]; then
            qdbus $dcopRef org.kde.kdialog.ProgressDialog.setLabelText "User canceled!" > /dev/null
            sleep 1
            qdbus $dcopRef org.kde.kdialog.ProgressDialog.close > /dev/null
            exit 1
        fi

        qdbus $dcopRef org.freedesktop.DBus.Properties.Set org.kde.kdialog.ProgressDialog value "$n" > /dev/null
        qdbus $dcopRef org.kde.kdialog.ProgressDialog.setLabelText "Processing '$FILE'" > /dev/null
        if ! ( jpegtran $OPERATION -copy all > "$FILE.tmp" < "$FILE" && mv -- "$FILE" "$FILE.old" && mv -- "$FILE.tmp" "$FILE" ); then
            [ -f "$FILE.tmp" ] && rm -f -- "$FILE.tmp"
            kdialog --title "$NAME ($OPERATION)" --error "Error processing '$FILE'!"
        else
            # For '-optimize' check sizes here and abort if bigger
            # ... TODO ...
            # Next two should work everywhere
            chown --reference="$FILE.old" "$FILE" || :
            chmod --reference="$FILE.old" "$FILE"
            # This will do what previous two did, but only if available
            getfacl -- "$FILE.old" | setfacl --set-file=- -- "$FILE" || :
            # Restore timestamps
            touch --reference="$FILE.old" "$FILE"
            # Add option to remove the old file here
            # ... TODO ...
        fi

        n=$[n+1]
    done
}


close() {
    OPERATION="$1"
    TOTAL="$2"
    qdbus $dcopRef org.kde.kdialog.ProgressDialog.setLabelText "Processed $TOTAL image(s)." > /dev/null
    qdbus $dcopRef org.freedesktop.DBus.Properties.Set org.kde.kdialog.ProgressDialog value "$TOTAL" > /dev/null
    sleep 1
    qdbus $dcopRef org.kde.kdialog.ProgressDialog.close > /dev/null
}


# main
if [ "$#" -lt "2" ]; then
    error_exit
fi
OPERATION="$1"
shift
TOTAL=$#
init "$OPERATION" $TOTAL
process "$OPERATION" "$@"
close "$OPERATION" $TOTAL
