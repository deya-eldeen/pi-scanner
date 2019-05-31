echo "------------------------------------------"
echo "| Showing MAC Addresses for all Pis      |";
echo "| Written By Deya Eldeen, deyaeldeen.com |";
echo "------------------------------------------"

PiMAC=$(sudo nmap -sN 192.168.8.* -p 22 | \
grep -i "pi" | \
awk '{print $3}' | \
awk '{print tolower($0)}') 
echo $PiMAC

echo "------------------------------------------"
echo "| Showing IP Addresses for all Pis       |";
echo "------------------------------------------"

arp -a  | while read -r j
do
    PiIP=$(echo $j | awk '{print $2,$4}' | \
    awk -F: '{printf("%02s:%02s:%02s:%02s:%02s:%02s",$1,$2,$3,$4,$5,$6)}' | \
    grep $PiMAC | \
    awk '{print $1}' | \
    tr -d '()');
	if [ ! -z "$PiIP" ]
	then
		echo $PiIP;
	fi
done
