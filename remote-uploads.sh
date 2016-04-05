#!/bin/bash

# Config file
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
	DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
	SOURCE="$( readlink "$SOURCE" )"
	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done

DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

CONFIG=${DIR%/*/*/*}

# Import config settings
source "$CONFIG/.env"

# Create uploads directory just in case it doesn't exist
mkdir -p $CONFIG$APP_DOCROOT$APP_UPLOADS

if [[ $1 = "enable" ]]; then

	if [[ $APP_SSL = "true" ]]; then
		echo Creating file: $APP_DOCROOT$APP_UPLOADS/.htaccess
		sed -e 's#__REPLACE__#'https://$DOMAIN_REMOTE'#g' $CONFIG/vendor/scottjs/helper-scripts/.htaccess-sample > $CONFIG$APP_DOCROOT$APP_UPLOADS/.htaccess
		echo COMPLETE: Loading remote uploads now enabled: https://$DOMAIN_REMOTE$APP_UPLOADS
	else
		echo Creating file: $APP_DOCROOT$APP_UPLOADS/.htaccess
		sed -e 's#__REPLACE__#'http://$DOMAIN_REMOTE'#g' $CONFIG/vendor/scottjs/helper-scripts/.htaccess-sample > $CONFIG$APP_DOCROOT$APP_UPLOADS/.htaccess
		echo COMPLETE: Loading remote uploads now enabled: http://$DOMAIN_REMOTE$APP_UPLOADS
	fi

elif [[ $1 = "disable" ]]; then

	echo Removing file: $APP_DOCROOT$APP_UPLOADS/.htaccess

	rm -rf "$CONFIG$APP_DOCROOT$APP_UPLOADS/.htaccess"

	echo COMPLETE: Loading remote uploads now disabled

fi
