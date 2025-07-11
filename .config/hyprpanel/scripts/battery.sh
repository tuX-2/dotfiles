#!/bin/bash

# Script de batería para HyprPanel
battery_info=$(upower -i $(upower -e | grep BAT))
percentage=$(echo "$battery_info" | grep percentage | awk '{print $2}' | sed 's/%//')
status=$(echo "$battery_info" | grep state | awk '{print $2}')

# Determinar el icono basado en el estado
if [[ "$status" == "charging" ]]; then
    icon="󰂄"  # Icono de carga
elif [[ "$percentage" -le 20 ]]; then
    icon="󰁺"  # Batería muy baja
elif [[ "$percentage" -le 40 ]]; then
    icon="󰁼"  # Batería baja
elif [[ "$percentage" -le 60 ]]; then
    icon="󰁾"  # Batería media
elif [[ "$percentage" -le 80 ]]; then
    icon="󰂀"  # Batería alta
else
    icon="󰁹"  # Batería completa
fi

# Salida en formato JSON para HyprPanel
printf '{"percentage": %d, "status": "%s", "icon": "%s"}' "$percentage" "$status" "$icon"
