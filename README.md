# thepower-analisis_de_datos-m5
Proyecto de análisis del M5. 

Este proyecto forma parte del Módulo 5, dedicado al manejo de bases de datos relacionales y al uso profesional de SQL.  
El objetivo principal ha sido trabajar con una base de datos completa de un videoclub, analizar sus tablas, practicar consultas de distinto nivel y documentar todo el proceso de forma clara.

---

## Herramientas utilizadas

- PostgreSQL  
- DBeaver 

---

## Base de datos utilizada

La base de datos está basada en un modelo clásico de videoclub.  
Incluye tablas como:

- **film**, **actor**, **category**
- **inventory**, **rental**, **payment**
- **customer**, **staff**, **store**
- **film_actor**, **film_category** (tablas puente)

El conjunto permite practicar relaciones uno-a-muchos y muchos-a-muchos, agregaciones, joins de distintos tipos, vistas y tablas temporales.

---

## Desarrollo del proyecto

### 1. Creación y configuración de la base de datos  
Creé una base de datos vacía en PostgreSQL y la conecté desde DBeaver.  
Tras eso, ejecuté el archivo `BBDD_Proyecto.sql` para generar todas las tablas iniciales.

### 2. Generación del ERD  
Con todas las tablas creadas, exporté el diagrama entidad–relación desde DBeaver.  
Este archivo (`esquema_BBDD.png`) muestra con claridad las primary keys, foreing keys y las relaciones entre tablas.

### 3. Resolución de las 64 consultas  
El archivo `consultas.sql` contiene **todas las consultas del enunciado**, del 1 al 64, perfectamente numeradas y revisadas.  
Incluye:

- Filtrados y búsquedas  
- Funciones agregadas (AVG, COUNT, SUM, STDDEV, VARIANCE…)  
- Subconsultas  
- Consultas con múltiples JOINs  
- LEFT JOIN, CROSS JOIN  
- Creación de **vistas**  
- Creación de **tablas temporales**  
- Consultas de análisis sobre alquileres, inventario, clientes y categorización de películas

### 4. Revisión y corrección  
Revisé consulta por consulta para asegurar:
- Correspondencia exacta con el enunciado  
- Resultados coherentes  
- Buena estructura SQL  
- Numeración correcta después de detectar y corregir un desfase en la consulta 41  
- Eliminación de consultas sobrantes  
- Archivo final completamente limpio y ordenado  

---

## Cómo ejecutar el proyecto

1. Crear una base de datos vacía en PostgreSQL.  
2. Ejecutar `BBDD_Proyecto.sql` para generar las tablas.  
3. Abrir `consultas.sql` desde DBeaver.  
4. Ejecutar las consultas según necesidad.  
5. Consultar el diagrama `esquema_BBDD.png` para entender la estructura.

---

## Conclusiones del análisis

Trabajar con esta base de datos permite visualizar fácilmente:

- Qué categorías de películas generan más alquileres.  
- Qué clientes son los que más ingresos aportan.  
- Qué actores participan en más películas.  
- Qué películas son más largas, más alquiladas o más rentables.  
- Cómo se comportan los alquileres según días, meses o duración.

---

Tomás Senor

- La importancia de las relaciones entre tablas  
- El uso de subconsultas y joins en escenarios reales  
- La utilidad de las vistas y tablas temporales para organizar análisis más complejos  
- El orden y la limpieza en el código SQL para trabajar de forma profesional  
