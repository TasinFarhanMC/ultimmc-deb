#!/bin/bash

INSTDIR="${XDG_DATA_HOME-$HOME/.local/share}"

deploy() {
    mkdir -p $INSTDIR
    cd ${INSTDIR}

    wget --progress=dot:force "https://nightly.link/UltimMC/Launcher/workflows/main/develop/mmc-cracked-lin64.zip" 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --auto-close --auto-kill --title="Downloading UltimMC..."

    unzip mmc-cracked-lin64.zip
    rm mmc-cracked-lin64.zip
    chmod +x UltimMC/UltimMC
}

runmmc() {
    cd ${INSTDIR}
    exec ./UltimMC/UltimMC "$@"
}

if [[ ! -f ${INSTDIR}/UltimMC/UltimMC ]]; then
    deploy
    runmmc "$@"
else
    runmmc "$@"
fi
