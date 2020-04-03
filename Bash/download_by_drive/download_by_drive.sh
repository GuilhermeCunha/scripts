#https://drive.google.com/file/d/1V7MwHuiibOgABOJ9Q6LeIgbhim2dsMkV/view?usp=sharing

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

GOOGLE_DRIVE_API_URL="https://docs.google.com/uc?export=download&id="

download_() {
    
    local file_id=$1
    local path=$2
    local file_name=$3
    local internal_url="https://docs.google.com/uc?export=download&id=$file_id"
    local final_url="https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate $internal_url -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=$file_id"
    echo "final_url: $final_url"
    echo -ne "# Baixando "$file_name"\t"
    #wget --no-check-certificate --progress=dot --continue --directory-prefix="$path" "$final_url" 2>&1 | grep --line-buffered "%" | sed -E "s,\.,,g" | awk '{printf("\b\b\b\b%4s", $2)}'
    wget --load-cookies /tmp/cookies.txt $final_url --directory-prefix="$path" -O $file_name && rm -rf /tmp/cookies.txt
    echo -ne "\b\b\b\b"
    echo " # Feito"
}

# download_ FILEID PATHDORESULTADO NOMEDOARQUIVO
download_ "fileid" "$outputPath" "filename.zip"

echo -e "\n### ------------------------------------------------------- ###\n"
echo "### Finalizado"
echo -e "\n### ------------------------------------------------------- ###\n"