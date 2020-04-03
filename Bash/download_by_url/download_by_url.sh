#!/bin/bash
ROOTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

CUSTOM_PATH=$1
if [ "$#" -eq 1 ]; then
    outputPath="$CUSTOM_PATH"
else
    outputPath="$ROOTPATH"
fi

if ! [ -x "$(command -v wget)" ]; then
    echo "Erro!: wget não instalado. Por favor realize a instalação de tente novamente."
    exit 1
fi

echo -e "\n### ------------------------------------------------------- ###\n"
echo "### Baixando dataset em $outputPath"
echo -e "\n### ------------------------------------------------------- ###\n"

download_() {
    local url=$1
    local path=$2
    local file_name=$3
    
    echo -ne "# Baixando "$file_name"\t"
    wget --progress=dot --continue --directory-prefix="$path" "$url" 2>&1 | grep --line-buffered "%" | sed -E "s,\.,,g" | awk '{printf("\b\b\b\b%4s", $2)}'
    echo -ne "\b\b\b\b"
    echo " # Feito"
}
# download_ URL PATHDORESULTADO NOMEDOARQUIVO
download_ "http://download1594.mediafire.com/6wmxwnrh28rg/rlrgm96m91rtm0b/arrow-left.svg" "$outputPath/01" "primeiro.svg"

echo -e "\n### ------------------------------------------------------- ###\n"
echo "### Finalizado"
echo -e "\n### ------------------------------------------------------- ###\n"