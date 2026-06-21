# Sinusoidal Generator & FIR Filter on FPGA (VHDL)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![VHDL](https://img.shields.io/badge/Language-VHDL-blue.svg)](https://en.wikipedia.org/wiki/VHDL)
[![Vivado](https://img.shields.io/badge/Tool-Vivado-orange.svg)](https://www.xilinx.com/products/design-tools/vivado.html)
[![FPGA](https://img.shields.io/badge/Target-Basys3%20FPGA-red.svg)](https://reference.digilentinc.com/reference/programmable-logic/basys-3/start)

## 📋 Descripción General

Diseño e implementación en **VHDL** de un sistema completo de **procesado digital de señal** en FPGA. Este proyecto fue desarrollado en la asignatura **Circuitos Integrados y Microelectrónica** de la **Universidad Carlos III de Madrid (UC3M)**.

El sistema integra tres componentes principales:
1. **Generador de señal senoidal digital** con 4 frecuencias seleccionables
2. **Filtro FIR (Finite Impulse Response)** para procesamiento de la señal
3. **Sistema de validación completo** verificado mediante simulación y síntesis en FPGA real

## 🎯 Características Principales

### Generador Senoidal
- ✅ Almacenamiento de 16 puntos por período en ROM
- ✅ Fórmula: `f(t) = 127 × sin(ωt)` (valores escalados a 8 bits con signo)
- ✅ 4 frecuencias seleccionables:
  - **500 Hz** (período = 2 ms)
  - **1000 Hz** (período = 1 ms)  
  - **2200 Hz** (período ≈ 0.45 ms)
  - **4000 Hz** (período = 0.25 ms)

### Filtro FIR
- ✅ **10 coeficientes** optimizados (arquitectura pasa-bajos)
- ✅ Dos implementaciones disponibles:
  - `filter_parallel.vhd`: Arquitectura paralela (máxima velocidad)
  - `FIR_pipeline_definitivo.vhd`: Arquitectura pipelined (menor latencia, mayor throughput)
- ✅ Coeficientes: `[1, 9, 38, 85, 123, 123, 85, 38, 9, 1]`
- ✅ Procesamiento @ 10 kHz de muestreo

### Sistema Integrado
- ✅ Frecuencia de reloj: **100 MHz**
- ✅ Precisión: **8 bits** (entrada y salida)
- ✅ Convertidor D/A (DAC) R2R mapeado a PMOD JA
- ✅ Visualización en tiempo real en 8 LEDs (Basys3)
- ✅ Control: 2 switches para selección de frecuencia + Reset

## 🏗️ Arquitectura del Proyecto

```
Sinusoidal-Generator-FIR-Filter-VHDL-FPGA/
├── src/                              # Código fuente VHDL
│   ├── TOP_P2.vhd                    # Módulo top-level (integración)
│   ├── Codigo_GenSen_GR4.vhd         # Generador de señal senoidal
│   ├── Codigo_ROM.vhd                # Memoria ROM con 16 puntos de seno
│   ├── generador_muestreo_10khz.vhd  # Generador de enable @ 10 kHz
│   ├── filter_parallel.vhd           # Filtro FIR paralelo
│   ├── FIR_pipeline_definitivo.vhd   # Filtro FIR pipelined
│   └── banco_pruebas_P2.vhd          # Testbench para simulación funcional
├── constraints/
│   └── Basys3_Master_GR4.xdc         # Pin mapping y timing constraints
├── CIM_LAB.pdf                       # Documentación detallada del proyecto
└── README.md                         # Este archivo
```

## 🔧 Tecnologías Utilizadas

| Tecnología | Propósito |
|---|---|
| **VHDL-2008** | Lenguaje de descripción hardware |
| **Vivado Design Suite** | Síntesis, place & route, simulación |
| **Xilinx Basys3** | FPGA de validación (Artix-7 XC7A35T) |
| **ISim/ModelSim** | Simulación funcional del testbench |

## 📊 Protocolo de Prueba

El testbench (`banco_pruebas_P2.vhd`) valida el sistema completo:

1. **Reset del sistema** (100 ns)
2. **Prueba 500 Hz**: Genera 2 ciclos (4 ms)
3. **Prueba 1000 Hz**: Genera 2 ciclos (2 ms)
4. **Prueba 2200 Hz**: Genera 1 ciclo (1 ms)
5. **Prueba 4000 Hz**: Genera 1 ciclo (1 ms)

Cada frecuencia se puede visualizar:
- **LED bruto**: Señal senoidal sin filtrar (complemento a 2)
- **DAC filtrado**: Señal tras filtro FIR en conversor R2R (binario natural)

## 🚀 Cómo Usar

### Requisitos
- Xilinx Vivado 2020.1 o superior
- FPGA Basys3 (opcional, para síntesis en hardware)
- ModelSim o ISim para simulación

### Pasos para Simulación

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/javisanz110/Sinusoidal-Generator-FIR-Filter-VHDL-FPGA.git
   cd Sinusoidal-Generator-FIR-Filter-VHDL-FPGA
   ```

2. **Crear proyecto en Vivado**
   - New Project → VHDL
   - Add Sources: todos los archivos de `src/`
   - Add Constraints: `Basys3_Master_GR4.xdc`

3. **Ejecutar simulación**
   - Set as Top: `banco_pruebas_P2`
   - Run Simulation → Observe LEDs y DAC en gráficos

4. **Síntesis en Basys3** (opcional)
   - Síntesis → Place & Route → Generate Bitstream
   - Programar FPGA y ajustar frecuencia con switches

## 📈 Resultados Observados

✅ **Generación senoidal**: Ondas suaves con 16 puntos muestreados

✅ **Filtrado FIR**: Atenuación de ruido, transiciones suaves

✅ **Timing**: Sistema estable @ 100 MHz con margen de setup/hold

✅ **Síntesis**: ~35% de utilización en Basys3 (LUTs: 850/20000)

## 📚 Documentación

Ver archivo **`CIM_LAB.pdf`** para:
- Especificación técnica completa
- Ecuaciones y cálculos de coeficientes FIR
- Resultados de síntesis detallados
- Diagramas de timing
- Análisis frecuencial

## 🎓 Créditos

**Autor**: Javier Sánchez González

**Universidad**: Universidad Carlos III de Madrid (UC3M)  
**Asignatura**: Circuitos Integrados y Microelectrónica  
**Año**: 2024

## 📄 Licencia

Este proyecto está bajo licencia **MIT** - ver LICENSE para más detalles.

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Para reportar bugs o sugerir mejoras, abre un **Issue** o **Pull Request**.

---

**⭐ Si este proyecto te fue útil, no olvides dejar una estrella en GitHub!**