1. mkdir test
2. cd test 
   touch etc_log.txt
   chmod 777 etc_log.txt 

3. su administrator// This way I can access the etc folder
   sudo -H /bin/bash
   ls -lR /etc > etc_log.txt 
4. ls -lR /run > run_log.txt
5. cat etc_log.txt run_log.txt > unsorted.txt 
   sort -r unsorted.txt > reversed.txt 
   
 

  

