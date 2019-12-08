#!/bin/bash
printf "\${color1}┣━os: \${color2}ARCH LINUX\n"
printf "\${color1}┣━architecture: \${color2}\${machine}\n"
printf "\${color1}┃\n"
printf "\${color1}┣━kernel: \${color2}\$kernel\n"
printf "\${color1}┣━packages: \${color2}"
pacman -Q | wc -l
printf "\${color1}┣━aur packages: \${color2}"
pacman -Qm | wc -l
printf "\${color1}┣━uptime: \${color2}\${uptime}\n"
printf "\${color1}┣━local: \${color2}\${addr wlp4s0}\n"
printf "\${color1}┣━last sync: "
GAP=$(($(date +%Y%m%d) - $(date -d $(grep 'full system upgrade' /var/log/pacman.log | tail -1 | cut -c2-11) +"%Y%m%d")))
if [ $GAP -lt 2 ]
then
    printf "\${color2}"
fi
