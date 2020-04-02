#!/bin/bash

shopt -s nullglob

for d in */ ; do
    cd "$d" || exit

    # Remove old file
    rm -f "${PWD##*/}-combined.pdf" pdffromimg.pdf

    # Determine name, time of submission and submitted files
    name=${PWD##*/}
    time=$(stat -c %y "$(ls -t | head -n1)")
    files=$(ls)
    filename="${PWD##*/}-combined.pdf"
    tmpfilename="../${PWD##*/}-tmp.pdf"
    echo "$d"
    echo "$name"
    echo "$time"
    echo "$files"

    rm -f "$tmpfilename"
    echo -e "Namn: $name\n\nInlämnad: $time\n\nInlämnade filer: $files" | pandoc -o "$tmpfilename"

    # Check if there are any jpg, jpeg, JPG
    imgfiles=(*.jpg *.jpeg *.JPG)
    # Convert all jpg, jpeg, JPG to one pdf
    if [ -e "${imgfiles[0]}" ];
    then
        img2pdf --pagesize A4 ./*.jpg ./*.jpeg ./*.JPG -o pdffromimg.pdf
    fi

    # Check if there are any doc or docx
    docfiles=(*.doc*)
    # Convert all doc and docx to individual pdfs
    if [ -e "${docfiles[0]}" ];
    then
        for f in *.doc* ; do
            lowriter --headless --convert-to pdf "$f"
        done
    fi

    # Join all pdf files from the student
    pdfjoin --rotateoversize false ./*.pdf -o "$filename"
    # Resize the pdf to A4
    pdfjam --a4paper "$filename" -o "$filename"

    # Add the information page to the end
    pdfjoin --rotateoversize false "$tmpfilename" "$filename" -o "$filename"

    # Remove information page
    rm -f "$tmpfilename"

    cd .. || exit
done
