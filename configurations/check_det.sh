while read -r first second third fourth rest; do
    ls $fourth
done < temp_det_input.txt
