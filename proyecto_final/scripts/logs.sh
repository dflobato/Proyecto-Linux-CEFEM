#!/bin/bash

# logs.sh - Simula eventos del sistema y analiza los logs

LOGDIR="./logs"
mkdir -p "$LOGDIR"
LOGFILE="$LOGDIR/eventos.log"

# Usuarios simulados
USUARIOS=(admin1 tecnico1 auditor1)

# Generar logs simulados
echo "Generando eventos simulados..."
> "$LOGFILE"  # Limpiar archivo anterior

for i in {1..30}; do
    TIPO_EVENTO=$(shuf -n 1 -e INFO WARNING ERROR LOGIN BACKUP)
    USUARIO=${USUARIOS[$RANDOM % ${#USUARIOS[@]}]}
    MENSAJE="Evento $TIPO_EVENTO generado por $USUARIO"
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

    echo "$TIMESTAMP [$TIPO_EVENTO] $MENSAJE" >> "$LOGFILE"
done

echo "Archivo de eventos generado en: $LOGFILE"
echo "Analizando el archivo de logs..."

# Número total de errores
NUM_ERRORES=$(grep "\[ERROR\]" "$LOGFILE" | wc -l)
echo
echo "Número total de errores: $NUM_ERRORES"

# Últimos 5 errores
echo
echo "Últimos 5 errores:"
grep "\[ERROR\]" "$LOGFILE" | tail -n 5

# Mensajes más frecuentes
echo
echo "Tipos de eventos más frecuentes:"
cut -d '[' -f2 "$LOGFILE" | cut -d ']' -f1 | sort | uniq -c | sort -nr

# Usuarios con más actividad
echo
echo "Usuarios con más actividad:"
awk '{print $NF}' "$LOGFILE" | sort | uniq -c | sort -nr

# Exportar análisis
INFORME="$LOGDIR/analisis_logs.txt"
{
    echo "===== Análisis de logs ====="
    echo "Fecha: $(date)"
    echo
    echo "Número total de errores: $NUM_ERRORES"
    echo
    echo "Últimos 5 errores:"
    grep "\[ERROR\]" "$LOGFILE" | tail -n 5
    echo
    echo "Tipos de eventos más frecuentes:"
    cut -d '[' -f2 "$LOGFILE" | cut -d ']' -f1 | sort | uniq -c | sort -nr
    echo
    echo "Usuarios con más actividad:"
    awk '{print $NF}' "$LOGFILE" | sort | uniq -c | sort -nr
} > "$INFORME"

echo
echo "Análisis exportado a: $INFORME"

