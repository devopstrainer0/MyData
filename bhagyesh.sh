 #!/bin/bash


# Set the output file name
output_file="output1.html"
count=count.txt
# Start the HTML file with basic structure
echo "<!DOCTYPE html>" > $output_file
echo "<html>" >> $output_file
echo "<head>" >> $output_file
echo "<title>JSON to HTML Example</title>" >> $output_file
echo "<style>" >> $output_file
echo "table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
  padding-top: 10px;
  padding-bottom: 20px;
  padding-left: 30px;
  padding-right: 40px;

}

.textWhite {
  color: white;
  background-color: #00008B;
}
" >> $output_file
echo "</style>" >> $output_file
echo "</head>" >> $output_file
echo "<body>" >> $output_file
echo "<table>" >> $output_file
echo "<th class="textWhite">Application name</th>" >> $output_file
echo "<th class="textWhite">failure</th>" >> $output_file
echo "<th class="textWhite">status</th>" >> $output_file
echo "<th class="textWhite">Display Name</th>" >> $output_file
echo "<th class="textWhite">reason</th>" >> $output_file

# Loop through each JSON file
for file in *.json
do
  
  
  # Extract the data from the JSON file using jq
  data=$(jq '.scanresults[0].jsonresult.vul' $file)
  
   nlength=0
   echo "$data" | jq -c '.[]' | while read i; do
     tlength=$(echo "$i" | jq -r '.violations'| grep conditionReason | grep severity| cut -d ":" -f2| wc -l)
     #dlength=$(echo "$i" | jq -r '.display'|wc -l)
     nlength=$((tlength+nlength+1))
      echo $nlength > $count
    echo "tlength is : $tlength"
    echo "nlength is : $nlength"  
    #echo "dlength is : $dlength"
  
  
    done
 
  row_count=`cat $count`
  
  echo "row_count is : $row_count"
  
  length=$(echo $data | jq '. | length')
  echo "length is : $length"
	
	

  
  if [ $(jq -r  '.scanresults[0].jsonresult.status' $file) = "Pass" ]; then
    row_count=0
   echo "<tr><th rowspan="$((row_count+1))">$(basename $file .json)</th>"  >> $output_file
  echo "<th rowspan="$((row_count+1))">$(jq '.scanresults[0].jsonresult.failure' $file)</th>"  >> $output_file
   echo "<th rowspan="$((row_count+1))"><font color="green">$(jq -r '.scanresults[0].jsonresult.status' $file)</font></th><td></td><td></td></tr>"  >> $output_file

else
 echo	"<tr><th rowspan="$((row_count+1))">$(basename $file .json)</th>"  >> $output_file
  echo "<th rowspan="$((row_count+1))">$(jq '.scanresults[0].jsonresult.failure' $file)</th>"  >> $output_file
   echo "<th rowspan="$((row_count+1))"><font color="red">$(jq -r '.scanresults[0].jsonresult.status' $file)</font></th></tr>"  >> $output_file

fi


 
  # Add the data to the HTML file as a table
    echo "$data" | jq -c '.[]' | while read i; do
     vlength=$(echo "$i" | jq -r '.violations'| grep conditionReason | grep severity| cut -d ":" -f2| wc -l)
    echo "vlength is : $vlength"
  
    echo "<tr><td rowspan="$((vlength+1))">$(echo "$i" | jq -r '.display')</td></tr>" >> $output_file
    
     echo "$i" | jq -r '.violations'| grep conditionReason | grep severity| cut -d ":" -f2 | while read line; do
   # echo $line
    echo "<tr><td>$(echo $line)</td></tr>" >> $output_file
    
    done
	
done
  
  
  
done


 
# Close the HTML file
echo "</body>" >> $output_file
echo "</html>" >> $output_file

ls -ltr
