
Рабочие файлы. (For PC with Endless OS).

Работают с devboard "Olimex ICE40HX1K-EVB", iceprogduino (Arduino Leonardo).

Build "iceprogduino" into Endless OS.
1. Run gnome-terminal into project directory.
2. user@endless:~"project directory"$ toolbox enter (if not exist - user@endless:~$ toolbox create)
3. user@toolbox:~"project directory"$ sudo dnf install gcc
4. user@toolbox:~"project directory"$ make
5. user@toolbox:~"project directory"$ exit
6. Copy "iceprogduino" to .platformio/packages/tool-iceprogduino

For iverylog simulator:
1. user@endless:~"project directory"$ toolbox enter
2. user@toolbox:~"project directory"$ sudo dnf install iverylog
3. user@toolbox:~"project directory"$ sudo dnf install gtkwave
4. user@toolbox:~"project directory"$ exit
5. Into file main.py change:
6. "vvp" -> "toolbox run vvp"
7. "gtkwave" -> "toolbox run gtkwave"
8. user@endless:~"project directory"$ platformio run -t sim

Or:
1. Install GtkWave
2. Into file main.py change:
3. "gtkwave" -> "flatpak run io.github.gtkwave.GTKWave"

Полезные ссылки ...
1. PlatformIO Core (CLI) : https://docs.platformio.org/en/stable/core/index.html
2. Devboard "Olimex iCE40HX1K-EVB" : https://www.olimex.com/Products/FPGA/iCE40/iCE40HX1K-EVB/open-source-hardware
3. Olimex/iCE40HX1K-EVB : https://github.com/OLIMEX/iCE40HX1K-EVB
4. platformio/lattice_ice40 : https://registry.platformio.org/platforms/platformio/lattice_ice40

