#!/bin/bash
# https://computingforgeeks.com/how-to-install-python-on-ubuntu-linux-system/
# Definir las versiones de Python que deseas instalar
versiones=("3.10.11" "3.9.10" "3.8.16")

# Iterar sobre cada versión y realizar la instalación
for version in "${versiones[@]}"; do
    echo "Instalando Python $version"

    wget "https://www.python.org/ftp/python/$version/Python-$version.tgz"
    tar -xf "Python-$version.tgz"
    cd "Python-$version/"
    ./configure --enable-optimizations
    make -j "$(nproc)"
    sudo make altinstall
    cd ..

    echo "Python $version instalado correctamente"
done
