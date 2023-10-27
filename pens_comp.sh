#!/bin/bash

# Verifique se foi fornecido um link de repositório como argumento.
if [ $# -ne 1 ]; then
  echo "Uso: $0 <link_do_repositorio>"
  exit 1
fi

# Diretório de destino (pasta Downloads).
download_dir="$HOME/Downloads"

# Verifica se a pasta do repositório já existe em Downloads.
if [ -d "$download_dir/$(basename $1 .git)" ]; then
  echo "A pasta do repositório já existe. Removendo..."
  rm -rf "$download_dir/$(basename $1 .git)"
fi

# Clona o repositório.
git clone "$1" "$download_dir/$(basename $1 .git)"

# Abre os arquivos style.css e index.html no Sublime Text.
subl "$download_dir/$(basename $1 .git)/style.css"
subl "$download_dir/$(basename $1 .git)/index.html" &
subl_pid=$!

# Abre o arquivo index.html no Firefox (assumindo que o Firefox está instalado).
firefox "$download_dir/$(basename $1 .git)/index.html" &
firefox_pid=$!

# Espera o fechamento do Firefox e do Sublime Text.
wait $firefox_pid
wait $subl_pid

# Após o fechamento dos programas, remove os arquivos locais.
echo "Removendo arquivos locais, certifique-se de ter enviado ao GitHub."
rm -rf "$download_dir/$(basename $1 .git)"
