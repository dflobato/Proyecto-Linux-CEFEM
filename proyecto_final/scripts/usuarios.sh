#!/bin/bash

# usuarios.sh - Script para crear usuarios, grupos, directorios y aplicar permisos especiales.

# Colores para salida
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

echo -e "${GREEN}Iniciando configuración de usuarios y permisos...${RESET}"

# Crear grupos
echo -e "${YELLOW}Creando grupos...${RESET}"
groupadd administracion
groupadd tecnicos

# Crear usuarios y asignarlos a grupos
echo -e "${YELLOW}Creando usuarios...${RESET}"
useradd -m -s /bin/bash admin1
useradd -m -s /bin/bash tecnico1
useradd -m -s /bin/bash auditor1

usermod -aG administracion admin1
usermod -aG tecnicos tecnico1

# Crear directorios
echo -e "${YELLOW}Creando directorios...${RESET}"
mkdir -p /tmp/empresa/admin
mkdir -p /tmp/empresa/tecnicos
mkdir -p /tmp/empresa/compartido

# Asignar propietarios y grupos
chown admin1:administracion /tmp/empresa/admin
chown tecnico1:tecnicos /tmp/empresa/tecnicos
chown root:root /tmp/empresa/compartido

# Permisos especiales
echo -e "${YELLOW}Aplicando permisos especiales...${RESET}"
chmod 4750 /tmp/empresa/admin       # SetUID
chmod 2750 /tmp/empresa/tecnicos    # SetGID
chmod 1777 /tmp/empresa/compartido  # Sticky Bit

# Crear un archivo de prueba para aplicar ACL
touch /tmp/empresa/tecnicos/reporte.txt
chown tecnico1:tecnicos /tmp/empresa/tecnicos/reporte.txt
chmod 640 /tmp/empresa/tecnicos/reporte.txt

# Dar acceso específico a auditor1 con ACL
setfacl -m u:auditor1:r-- /tmp/empresa/tecnicos/reporte.txt

# Guardar información de usuarios y permisos
OUTDIR="./usuarios"
mkdir -p "$OUTDIR"

echo "Usuarios y Grupos:" > "$OUTDIR/info_usuarios.txt"
id admin1 >> "$OUTDIR/info_usuarios.txt"
id tecnico1 >> "$OUTDIR/info_usuarios.txt"
id auditor1 >> "$OUTDIR/info_usuarios.txt"

echo -e "\nPermisos del directorio /tmp/empresa:" >> "$OUTDIR/info_usuarios.txt"
ls -ld /tmp/empresa/* >> "$OUTDIR/info_usuarios.txt"

echo -e "\nACL del archivo reporte.txt:" >> "$OUTDIR/info_usuarios.txt"
getfacl /tmp/empresa/tecnicos/reporte.txt >> "$OUTDIR/info_usuarios.txt"

echo -e "${GREEN}Usuarios, grupos, permisos y ACLs configurados con éxito.${RESET}"
