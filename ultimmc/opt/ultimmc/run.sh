#!/bin/bash

INSTDIR="${XDG_DATA_HOME-$HOME/.local/share}/ultimmc"

deploy() {
    mkdir -p $INSTDIR
    cd ${INSTDIR}

    wget --progress=dot:force "https://nightly.link/UltimMC/Launcher/workflows/main/develop/mmc-cracked-lin64.zip" 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --auto-close --auto-kill --title="Downloading UltimMC..."

    tar -xzf ${PACKAGE} --transform='s,UltimMC/,,'
    rm ${PACKAGE}
    chmod +x UltimMC
}

runmmc() {
    cd ${INSTDIR}
    exec ./UltimMC "$@"
}

if [[ ! -f ${INSTDIR}/UltimMC ]]; then
    deploy
    runmmc "$@"
else
    runmmc "$@"
fi
