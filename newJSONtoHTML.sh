 #!/bin/bash


# Set the output file name
output_file="output1.html"
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
# Loop through each JSON file
for file in *.json
do
  

  # Extract the data from the JSON file using jq
  data=$(jq '.scanresults[0].jsonresult.vul' $file)
  length=$(echo $data | jq '. | length')
  echo "length is : $length"

  
  echo	"<tr><th rowspan="$((length+1))">$(basename $file .json)</th>"  >> $output_file
  echo "<th rowspan="$((length+1))">$(jq '.scanresults[0].jsonresult.failure' $file)</th>"  >> $output_file
  
  if [ $(jq -r  '.scanresults[0].jsonresult.status' $file) = "Pass" ]; then
   echo "<th rowspan="$((length+1))"><font color="green">$(jq -r '.scanresults[0].jsonresult.status' $file)</font></th></tr>"  >> $output_file

else
   echo "<th rowspan="$((length+1))"><font color="red">$(jq -r '.scanresults[0].jsonresult.status' $file)</font></th></tr>"  >> $output_file

fi	


   
  # Add the data to the HTML file as a table
   echo "$data" | jq -c '.[]' | while read i; do
	
  
    echo "<tr><td>$(echo "$i" | jq -r '.display')</td></tr>" >> $output_file
	
done
  
  
done

# Close the HTML file
echo "</body>" >> $output_file
echo "</html>" >> $output_file

ls -ltr
