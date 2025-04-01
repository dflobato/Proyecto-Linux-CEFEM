#!/bin/bash

# main.sh - Menú interactivo para administrar tareas del sistema

# Colores
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

# Ruta base
BASE_DIR=$(dirname "$0")
SCRIPTS_DIR="$BASE_DIR/scripts"
LOGS_DIR="$BASE_DIR/logs"
RESPALDO_DIR="$BASE_DIR/respaldo"

# Función: Crear usuarios y permisos
crear_usuarios() {
    echo -e "${BLUE}Ejecutando script de usuarios...${RESET}"
    sudo bash "$SCRIPTS_DIR/usuarios.sh"
}

# Función: Generar y analizar logs
analizar_logs() {
    echo -e "${BLUE}Ejecutando script de logs...${RESET}"
    bash "$SCRIPTS_DIR/logs.sh"
}

# Función: Simular backup
crear_backup() {
    echo -e "${BLUE}Simulando backup...${RESET}"
    mkdir -p "$RESPALDO_DIR"
    FECHA=$(date +%Y%m%d_%H%M%S)
    DESTINO="$RESPALDO_DIR/respaldo_$FECHA.tar.gz"
    tar -czf "$DESTINO" "$LOGS_DIR" "$BASE_DIR/usuarios" 2>/dev/null
    echo "Backup creado en: $DESTINO"
}

# Función: Ver espacio en disco
espacio_disco() {
    echo -e "${BLUE}Espacio en disco:${RESET}"
    df -h
}

# Función: Limpiar archivos temporales viejos
limpiar_tmp() {
    echo -e "${BLUE}Eliminando archivos temporales viejos en /tmp (más de 7 días)...${RESET}"
    sudo find /tmp -type f -mtime +7 -exec rm -f {} \;
    echo "Limpieza completada."
}

# Función: Mostrar menú
mostrar_menu() {
    echo -e "${YELLOW}"
    echo "===== MENÚ PRINCIPAL ====="
    echo "1. Crear estructura de usuarios y permisos"
    echo "2. Generar y analizar logs"
    echo "3. Crear backup de directorios críticos"
    echo "4. Mostrar espacio disponible en disco"
    echo "5. Limpiar archivos temporales viejos"
    echo "6. Salir"
    echo -e "${RESET}"
}

# Loop principal
while true; do
    mostrar_menu
    read -rp "Seleccione una opción [1-6]: " opcion

    case $opcion in
        1) crear_usuarios ;;
        2) analizar_logs ;;
        3) crear_backup ;;
        4) espacio_disco ;;
        5) limpiar_tmp ;;
        6) echo -e "${GREEN}Saliendo...${RESET}"; exit 0 ;;
        *) echo -e "${RED}Opción inválida. Intente nuevamente.${RESET}" ;;
    esac

    echo
    read -rp "Presione Enter para continuar..."
    clear
done

