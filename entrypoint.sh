#!/bin/bash
# If any commands fail (exit code other than 0) entire script exits
set -e

# Begin from the ~/clone directory
# this directory is the default your git project is checked out into by Codeship.

cd ${working_directory:-./}

composer_path="./composer.json"
package_path="./package.json"
bower_file_path="./bower.json"

webpack_path="./Build/config.base.js"
webpack_path_lower="./build/config.base.js"

# If we have composer dependencies make sure they are installed
if [ -f "$composer_path" ]
then
	echo "Composer File found. Starting composer install."
	composer install
fi

if [ -f "$webpack_path" ]
then
	build_type=webpack
fi

if [ -f "$webpack_path_legacy" ]
then	
	build_type=webpack
fi

if [ -f "$webpack_path_other_legacy" ]
then
	build_type=webpack
fi

if [ -f "$webpack_path_lower" ]
then
	build_type=webpack
fi

# check to see our build type and if so build using either gulp or grunt
if [ "$build_type" != "none" ]
then
		if [ "$build_type" == "webpack" ]
		then
			echo "Webpack File Found. Starting Yarn Install"
			yarn install
			echo "Deploy Webpack"
			yarn deploy
		else
	    echo "Initiating Yarn Install"
	    yarn install
	fi
fi

cd ..
