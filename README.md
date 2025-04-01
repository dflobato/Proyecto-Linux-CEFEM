# Proyecto Final - Automatización y Administración de Sistemas en Bash (WSL2)

## Descripción del Proyecto

Este proyecto automatiza tareas del sistema utilizando scripts en Bash sobre WSL2. Forma parte del curso "Automatización y Administración de Sistemas". El entorno simula tareas comunes del departamento de informática en una empresa ficticia llamada **TecnoGest**.

## Estructura del Proyecto

```
proyecto_final/
├── main.sh                   # Script principal con menú interactivo
├── README.md                 # Documentación del proyecto
├── scripts/                  # Scripts auxiliares
│   ├── usuarios.sh           # Gestión de usuarios, grupos y permisos
│   └── logs.sh               # Simulación y análisis de logs
├── logs/                     # Carpeta donde se guardan los logs generados
├── usuarios/                 # Carpeta con información de usuarios y permisos
└── respaldo/                 # Carpeta con backups simulados
```
## Dependencias del Sistema

Este proyecto requiere que el sistema tenga soporte para ACL (Access Control Lists), ya que se utiliza `setfacl` y `getfacl`.

En sistemas basados en Debian/Ubuntu (como WSL2), puedes instalarlo ejecutando:

```bash
sudo apt update
sudo apt install acl
```

## Cómo Ejecutar el Proyecto

1. Clonar el repositorio o copiar los archivos a un directorio local:

```bash
git clone https://github.com/dflobato/Proyecto-Linux-CEFEM.git
cd proyecto_final
```

2. Dar permisos de ejecución:

```bash
chmod +x main.sh scripts/*.sh
```

3. Ejecutar el menú interactivo:

```bash
./main.sh
```

> Nota: algunos scripts requieren permisos de superusuario (`sudo`), especialmente para crear usuarios o modificar `/tmp`.

## Descripción de los Scripts

### main.sh

Script principal que muestra un menú con opciones para:

- Crear estructura de usuarios y permisos.
- Generar y analizar logs.
- Crear backup simulado.
- Ver espacio en disco.
- Limpiar archivos temporales antiguos.

### scripts/usuarios.sh

- Crea los usuarios: `admin1`, `tecnico1`, `auditor1`.
- Crea grupos: `administracion`, `tecnicos`.
- Asigna usuarios a grupos.
- Crea directorios `/tmp/empresa/` con permisos especiales: SetUID, SetGID, Sticky Bit.
- Aplica permisos ACL para `auditor1`.
- Guarda la información generada en `usuarios/info_usuarios.txt`.

### scripts/logs.sh

- Genera un archivo de logs `logs/eventos.log` con al menos 30 eventos simulados.
- Analiza los logs y muestra:
  - Número total de errores.
  - Últimos 5 errores.
  - Eventos más frecuentes.
  - Usuarios con más actividad.
- Exporta el informe en `logs/analisis_logs.txt`.

## Ejemplos de Uso

- Para crear usuarios y estructura de permisos:

```bash
./main.sh
# Elegir opción 1 en el menú
```

- Para generar y analizar logs:

```bash
# Elegir opción 2 en el menú
```

- Para simular un backup:

```bash
# Elegir opción 3 en el menú
```

## Requisitos Técnicos

- Bash (compatible con WSL2)
- Comandos: `chmod`, `chown`, `setfacl`, `getfacl`, `grep`, `awk`, `cut`, `find`, `tar`
- Permisos especiales: SetUID, SetGID, Sticky Bit
- Uso de estructuras de control: funciones, bucles, condicionales, case

## Autor

- Nombre: [Diego Franganillo Lobato]
- Modalidad: [Individual]
- Curso: Automatización y Administración de Sistemas en Bash (WSL2)
