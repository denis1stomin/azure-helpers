# get full download page
curl -o page.html https://www.microsoft.com/en-us/download/confirmation.aspx?id=41653
# find actual xml download path
cat page.html | grep -m 1 -Po 'https://download\.microsoft\.com/.+?PublicIPs_[0-9]+\.xml'>link.txt
# download IPs xml
curl -o ip_ranges.xml $(head -n 1 link.txt)
# parse IPs xml for US geography
xmllint --xpath '/AzurePublicIpAddresses/Region[starts-with(@Name, "us")]/IpRange/@Subnet' ip_ranges.xml \
    | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/[0-9]+'>ip_ranges.txt
# TODO : update keyvault rules
