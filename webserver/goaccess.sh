#!/bin/bash
#
# Real-time web log analyzer.
#

U="$(stat . -c %U)"
#U="${1:-default-user}"

HTTP="ssl-"

IP="$IP"

Goaccess() {
    goaccess \
        --agent-list
        --http-method=yes \
        --geoip-city-data=/var/lib/geoip-database-contrib/GeoLiteCity.dat \
        --log-format='%h %^[%d:%t %^] "%r" %s %b "%R" "%u"' \
        --date-format='%d/%b/%Y'
        --time-format='%T' \
        --exclude-ip="$IP" "$@"
}

Goaccess -f /var/log/apache2/${U}-${HTTPS}access.log

# List log files by size
# ls -lSr /var/log/apache2/*access.log

# Multiple log files (not realtime)
#cat /var/log/apache2/${U}-{ssl-,}access.log | Goaccess


# HTML output
#Goaccess -f /var/log/apache2/${U}-${HTTPS}access.log -o /home/${U}/website/html/stat.html

# HTML output from multiple log files
#cat /var/log/apache2/${U}-{ssl-,}access.log | Goaccess -o /home/${U}/website/html/stat.html
