This is an experiment in recreating the output one would get from using the `dig` command line tool to get one's external IP Address.

The dig command to compare against is:

  `dig +short myip.opendns.com @resolver1.opendns.com`
  
This code replicates the process the `dig` binary uses in the above example.
