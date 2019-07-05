#!/bin/bash
echo "Hi this is some basic bash scripting practice"

# Parameter passing also $ is special so you can escape it
echo "The first parameter is \${0} ${0} which is the filename"
echo "The list of parameters is defined by \$@"


for arg in "$@"
	do
		if [ "$arg" == "--help" ] || [ "$arg" == "-h" ]; then
			echo "Print the help here"
			exit 0
		fi
		echo "The args in the script is $arg"
		sleep 1
	done
sleep 3
echo "The below snippet will loop through a directory and list the files"
# for loop across a list of files
for file in /tmp/*
	do
		echo "The file name is $file and this is also ${file}"
		echo "There is no difference between \${file} and \$file"
		sleep 1
		break
	done

echo "This is how to set the default parameter"
defvalue=1

VALUE=${2:-$defvalue}

echo "The argument number two to the script in case not provided is $VALUE"


echo "This is a way to write to an file"
cat <<EOF > custom.conf
server {
  listen 80;
  sendfile on;
  default_type application/octet-stream;
  gzip on;
  gzip_http_version 1.1;
  gzip_disable      "MSIE [1-6]\.";
  gzip_min_length   1100;
  gzip_vary         on;
  gzip_proxied      expired no-cache no-store private auth;
  gzip_types        text/plain text/css application/json application/javascript application/x-javascript text/xml application/xml application/xml+rss text/javascript;
  gzip_comp_level   9;
  root /usr/share/nginx/html;
  try_files $uri $uri/ index.html;
}
EOF
