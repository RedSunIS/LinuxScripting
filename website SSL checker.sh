# test if a site exists and if it is running SSL
# plans for improvements: test if there is a redirect (3xx http code) and pass the redirected URL recursively.
testSSL() {
  site=$1
  site_exists=`curl --silent --head --location --output /dev/null --write-out '%{http_code}' $site`
  if [ $site_exists != '000' ]; then
    if true | openssl s_client -connect $site:443 2>/dev/null | openssl x509 -noout -checkend 0; then
      : #do nothing
    else
      echo $site
    fi
  fi
}

run() {
testSSL google.com
}