#!/bin/bash

SERVICE="svxlink"
MAX_RESTARTS=5
RESTART_COUNT=0

while true; do
    # Preveri stanje storitve
    STATUS=$(systemctl is-active $SERVICE)
    
    if [ "$STATUS" != "active" ]; then
        echo "$(date): Storitev ni aktivna. Poskus ponovnega zagona..." >> /var/log/svxlink_healthcheck.log
        sudo systemctl restart $SERVICE
        
        # Preveri stanje po ponovnem zagonu
        sleep 5
        STATUS=$(systemctl is-active $SERVICE)
        
        if [ "$STATUS" != "active" ]; then
            ((RESTART_COUNT++))
            echo "$(date): Ponovni zagon ni uspel. Poskus št. $RESTART_COUNT" >> /var/log/svxlink_healthcheck.log
        else
            RESTART_COUNT=0
        fi
        
        # Če dosežemo maksimalno število poskusov, se ustavi
        if [ $RESTART_COUNT -ge $MAX_RESTARTS ]; then
            echo "$(date): Maksimalno število poskusov doseženo. Prekinjam." >> /var/log/svxlink_healthcheck.log
            exit 1
        fi
    else
        RESTART_COUNT=0
    fi

    # Počakaj 10 sekund pred naslednjo iteracijo
    sleep 10
done